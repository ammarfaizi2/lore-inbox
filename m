Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbULVIYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbULVIYW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 03:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbULVIYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 03:24:22 -0500
Received: from KECGATE03.infosys.com ([220.227.179.21]:46096 "EHLO
	kecgate03.infosys.com") by vger.kernel.org with ESMTP
	id S261831AbULVIYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 03:24:13 -0500
Subject: Re: zero copy issue while receiving the data (counter part of
	sendfil e)
From: Mandeep Sandhu <Mandeep_Sandhu@infosys.com>
To: dima@s2io.com
Cc: Jeff Garzik <jgarzik@pobox.com>,
       "Rajat Jain, Noida" <rajatj@noida.hcltech.com>,
       linux-newbie@vger.kernel.org, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       kernelnewbies <kernelnewbies@nl.linux.org>,
       "Sanjay Kumar, Noida" <sanjayku@hcltech.com>,
       "Deepak Kumar Gupta, Noida" <dkumar@hcltech.com>
In-Reply-To: <1103658190.7217.121.camel@beastie>
References: <267988DEACEC5A4D86D5FCD780313FBB02C66FCA@exch-03.noida.hcltech.com>
	 <1103649767.7217.100.camel@beastie>  <41C879CB.3040600@pobox.com>
	 <1103658190.7217.121.camel@beastie>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103703718.3775.93.camel@samish.india.ascend.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 22 Dec 2004 13:51:58 +0530
X-OriginalArrivalTime: 22 Dec 2004 08:20:23.0169 (UTC) FILETIME=[15350710:01C4E7FF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-22 at 01:13, Dmitry Yusupov wrote:
> indeed :)
> another words if you have modern NIC than you get "zero-copy"(except
> copy_to_user()) for free :)
what does "checksum on rx" mean??? Don't most of the NIC's support
DMA-ing to mem on rx-ing a packet? so what does "zero-copy for free"
mean here?

thanx,
-mandeep
> 
> Regards,
> Dima
> 
> On Tue, 2004-12-21 at 14:30 -0500, Jeff Garzik wrote:
> > Dmitry Yusupov wrote:
> > > Rajat,
> > > 
> > > small correction, if NIC supports DMA operation on receive, than no
> > > extra copy required. Therefore sock_recvmsg() and tcp_read_sock
> > 
> > large correction:  if NIC supports _checksum_ on receive, then no extra 
> > copy is required.
> > 
> > 	Jeff
> > 
> 
> 
> --
> Kernelnewbies: Help each other learn about the Linux kernel.
> Archive:       http://mail.nl.linux.org/kernelnewbies/
> FAQ:           http://kernelnewbies.org/faq/
> 
