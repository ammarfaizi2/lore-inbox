Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269050AbUJKPKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269050AbUJKPKD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 11:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269063AbUJKPGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 11:06:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:34958 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269043AbUJKPCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 11:02:51 -0400
Date: Mon, 11 Oct 2004 08:02:45 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andre Tomt <andre@tomt.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: Linux 2.6.9-rc4 - pls test (and no more patches)
In-Reply-To: <416A53D3.9020002@tomt.net>
Message-ID: <Pine.LNX.4.58.0410110758500.3897@ppc970.osdl.org>
References: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org>
 <416A53D3.9020002@tomt.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Oct 2004, Andre Tomt wrote:
> 
> The data corruption bug in the new megaraid driver version seems still 
> not to be fixed. LSI posted a fix some weeks ago, not sure how that went..
> 
> "[PATCH]: megaraid 2.20.4: Fixes a data corruption bug"

I think that one is already in the SCSI BK tree, just not pushed to me. 
Perhaps because the tree contains other less important patches that James 
doesn't think are worthy yet.. James? Should I just take the small 
megaraid patch directly (and leave the compat ioctl cleanups etc to you)?

		Linus
