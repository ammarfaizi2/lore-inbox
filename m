Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268405AbTBSNBL>; Wed, 19 Feb 2003 08:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268407AbTBSNBL>; Wed, 19 Feb 2003 08:01:11 -0500
Received: from ip68-13-105-80.om.om.cox.net ([68.13.105.80]:17030 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S268405AbTBSNBK>; Wed, 19 Feb 2003 08:01:10 -0500
Date: Wed, 19 Feb 2003 01:10:30 -0600 (CST)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@localhost.localdomain
To: Bill Davidsen <davidsen@tmr.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.62]: 2/3: Make SCSI low-level drivers also a seperate,
 complete selectable submenu
In-Reply-To: <Pine.LNX.3.96.1030218224242.7581B-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0302190105370.4923-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2003, Bill Davidsen wrote:

> On Tue, 18 Feb 2003, Christoph Hellwig wrote:
> 
> > On Tue, Feb 18, 2003 at 02:02:10PM +0100, Marc-Christian Petersen wrote:
> > > so you can disable all SCSI lowlevel drivers at once.
> > 
> > Why? just disable CONFIG_SCSI instead of adding an artifical option
> 
> Isn't that going to disable all of SCSI? I think the intention may be to
> drop hardware drivers and just use ide-scsi, although I might be
> misreading the original intent.
> 
> There are a fair number of tape/CD/DVD devices out there which you might
> run SCSI. I many cases will run SCSI or not at all.

I thought the intent was to make it unnecessary to run ide-scsi at all.  
There was talk about it awhile back on the list.  I've been burning CDs 
using ide cdrom support for several kernel revisions now.

