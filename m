Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbULUTaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbULUTaf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 14:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbULUTae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 14:30:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57751 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261301AbULUTa3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 14:30:29 -0500
Message-ID: <41C879CB.3040600@pobox.com>
Date: Tue, 21 Dec 2004 14:30:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dima@s2io.com
CC: "Rajat Jain, Noida" <rajatj@noida.hcltech.com>,
       linux-newbie@vger.kernel.org, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org,
       "Sanjay Kumar, Noida" <sanjayku@hcltech.com>,
       "Deepak Kumar Gupta, Noida" <dkumar@hcltech.com>
Subject: Re: zero copy issue while receiving the data (counter part of sen
 dfil e)
References: <267988DEACEC5A4D86D5FCD780313FBB02C66FCA@exch-03.noida.hcltech.com> <1103649767.7217.100.camel@beastie>
In-Reply-To: <1103649767.7217.100.camel@beastie>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Yusupov wrote:
> Rajat,
> 
> small correction, if NIC supports DMA operation on receive, than no
> extra copy required. Therefore sock_recvmsg() and tcp_read_sock

large correction:  if NIC supports _checksum_ on receive, then no extra 
copy is required.

	Jeff


