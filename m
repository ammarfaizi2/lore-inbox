Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbULUTns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbULUTns (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 14:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbULUTnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 14:43:45 -0500
Received: from ns1.s2io.com ([142.46.200.198]:50888 "EHLO ns1.s2io.com")
	by vger.kernel.org with ESMTP id S261512AbULUTnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 14:43:40 -0500
Subject: Re: zero copy issue while receiving the data (counter part of sen
	dfil e)
From: Dmitry Yusupov <dima@s2io.com>
Reply-To: dima@s2io.com
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Rajat Jain, Noida" <rajatj@noida.hcltech.com>,
       linux-newbie@vger.kernel.org, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org,
       "Sanjay Kumar, Noida" <sanjayku@hcltech.com>,
       "Deepak Kumar Gupta, Noida" <dkumar@hcltech.com>
In-Reply-To: <41C879CB.3040600@pobox.com>
References: <267988DEACEC5A4D86D5FCD780313FBB02C66FCA@exch-03.noida.hcltech.com>
	 <1103649767.7217.100.camel@beastie>  <41C879CB.3040600@pobox.com>
Content-Type: text/plain
Organization: S2io Technologies
Date: Tue, 21 Dec 2004 11:43:10 -0800
Message-Id: <1103658190.7217.121.camel@beastie>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -106.7
X-Spam-Outlook-Score: ()
X-Spam-Features: BAYES_01,EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_IN_WHITELIST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

indeed :)
another words if you have modern NIC than you get "zero-copy"(except
copy_to_user()) for free :)

Regards,
Dima

On Tue, 2004-12-21 at 14:30 -0500, Jeff Garzik wrote:
> Dmitry Yusupov wrote:
> > Rajat,
> > 
> > small correction, if NIC supports DMA operation on receive, than no
> > extra copy required. Therefore sock_recvmsg() and tcp_read_sock
> 
> large correction:  if NIC supports _checksum_ on receive, then no extra 
> copy is required.
> 
> 	Jeff
> 

