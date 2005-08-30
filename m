Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbVH3Vtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbVH3Vtq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 17:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbVH3Vtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 17:49:46 -0400
Received: from web53604.mail.yahoo.com ([206.190.37.37]:10399 "HELO
	web53604.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932485AbVH3Vtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 17:49:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=FAgLE/jvOr47DSGJ8GgqZ55abzBGOej1nbJ5TfSM9FSdKWjLRtuCKONsbsiMa8ulTCuncAJ0NTSP6+UY6QAeKv0lBKRJ05z6QC0dX66Z/5LVD02JZwkMbaGRRbOGS9LBduzF1trUN2FnMWkskB6vkS6/UMbX75q88lXIt8p23jw=  ;
Message-ID: <20050830214937.22956.qmail@web53604.mail.yahoo.com>
Date: Wed, 31 Aug 2005 07:49:37 +1000 (EST)
From: Steve Kieu <haiquy@yahoo.com>
Subject: Re: Very strange Marvell/Yukon Gigabit NIC networking problems
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Jesse Brandeburg <jesse.brandeburg@gmail.com>,
       Daniel Drake <dsd@gentoo.org>, Steve Kieu <haiquy@yahoo.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20050830140516.316e9695@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Stephen Hemminger <shemminger@osdl.org> wrote:

> You have a version of the Marvell Yukon that was
> affected
> by a fix in 2.6.13.
> 	skge addr 0xfeaf8000 irq 19 chip Yukon-Lite rev 9
> 
> Both the skge and sk98lin driver were fixed to check
> for this.
> Without the fix, the chip will be in the wrong power
> mode.
> 
> The version of sk98lin driver from SysKonnect
> already had the
> fix, so if your distro used that one, it would have
> the reset
> the power mode as needed.

I am afraid not. The last time, I reproduced the
problem using the latest sk98lin driver from
SysKonnect  (run create patch and patch the kernel
2.6.13). Problem still there. The file I got from
sysconnect is:

install-8_23.tar.bz2

> 


S.KIEU


	

	
		
____________________________________________________ 
Do you Yahoo!? 
The New Yahoo! Movies: Check out the Latest Trailers, Premiere Photos and full Actor Database. 
http://au.movies.yahoo.com
