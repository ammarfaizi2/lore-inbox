Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbWEQTD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWEQTD3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 15:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbWEQTD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 15:03:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:23758 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750976AbWEQTD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 15:03:28 -0400
Date: Wed, 17 May 2006 21:03:26 +0200
From: Olaf Hering <olh@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ignore partition table on disks with AIX label
Message-ID: <20060517190326.GA29017@suse.de>
References: <20060517081314.GA20415@suse.de> <200605170853.k4H8rn8K009466@turing-police.cc.vt.edu> <20060517091056.GA21219@suse.de> <200605171014.k4HAETHT011371@turing-police.cc.vt.edu> <20060517183710.GA28931@suse.de> <1147892187.10470.70.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1147892187.10470.70.camel@localhost.localdomain>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, May 17, Alan Cox wrote:

> On Mer, 2006-05-17 at 20:37 +0200, Olaf Hering wrote:
> > A big company who is all hot about Linux expressed no interrest so far
> > to make AIX volumes readable in Linux.
> 
> All we want to know initially is how to correctly spot AIX volumes. As I

I dont have any more info about the layout.
The code for AIX in fdisk was added around 1999-03-20. So if anyone had
any trouble with matching the 4 byte at the beginning of the disks,
fdisk would do more or different checks before rejecting such a disk.
I'm not sure if fdisk was always the tool of choice, but its a good
measure.
