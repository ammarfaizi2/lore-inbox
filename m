Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269163AbUJKSWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269163AbUJKSWW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 14:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269170AbUJKSWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 14:22:22 -0400
Received: from gw.pasop.tomt.net ([80.239.42.1]:11909 "EHLO puppen.tomt.net")
	by vger.kernel.org with ESMTP id S269163AbUJKSWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 14:22:19 -0400
Message-ID: <416ACF5E.80407@tomt.net>
Date: Mon, 11 Oct 2004 20:22:22 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc4 - pls test (and no more patches)
References: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org>	<416A53D3.9020002@tomt.net> 	<Pine.LNX.4.58.0410110758500.3897@ppc970.osdl.org> <1097507381.2029.40.camel@mulgrave>
In-Reply-To: <1097507381.2029.40.camel@mulgrave>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Mon, 2004-10-11 at 10:02, Linus Torvalds wrote:
>>On Mon, 11 Oct 2004, Andre Tomt wrote:
>>>"[PATCH]: megaraid 2.20.4: Fixes a data corruption bug"
>>
>>I think that one is already in the SCSI BK tree, just not pushed to me. 
>>Perhaps because the tree contains other less important patches that James 
>>doesn't think are worthy yet.. James? Should I just take the small 
>>megaraid patch directly (and leave the compat ioctl cleanups etc to you)?
> 
> I have no objections.  However, I was planning on pushing it through the
> SCSI tree because it's in the new megaraid driver which is experimental
> at the moment (the old megaraid driver is still in and still
> selectable).  It's been in -mm for a few days now with no ill effects, I
> think, but I'm not sure how many megaraid owners have actually tested
> it.

I've been running 2.20.3.1 + the data corruption bug fix on megaraids 
ranging from low-end SATA adapters to the u320scsi ones for a while on a 
2.6.8 based kernel, nothing have blown up yet. The old 2.20.3.1 without 
the fix have been holding up too though - however having a known data 
corruption bug lingering doesn't feel so good :-)
