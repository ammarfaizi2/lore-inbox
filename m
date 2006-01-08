Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbWAHQll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbWAHQll (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 11:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752619AbWAHQll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 11:41:41 -0500
Received: from mail.kroah.org ([69.55.234.183]:56730 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751454AbWAHQlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 11:41:40 -0500
Date: Sun, 8 Jan 2006 08:27:43 -0800
From: Greg KH <greg@kroah.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Adrian Bunk <bunk@stusta.de>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-git2: CONFIGFS_FS shows up as M/y choice, help says "if unsure, say N"
Message-ID: <20060108162743.GA27234@kroah.com>
References: <5a4c581d0601061310j3f4eb310o1d68c0b87c278685@mail.gmail.com> <20060106223032.GZ18439@ca-server1.us.oracle.com> <20060107220959.GA3774@stusta.de> <20060108021630.GA3771@kroah.com> <Pine.LNX.4.61.0601081247150.30148@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601081247150.30148@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 12:48:03PM +0100, Jan Engelhardt wrote:
> >> Why is CONFIGFS_FS a user-visible option?
> >
> >I think it should be the same as SYSFS, only changable from the EMBEDDED
> >portion.
> >
> At its present state, no distribution uses configfs afaik, so I'd love to 
> have that turned off to not enlarge the kernel binary unnecessary.

Well, ocfs2 needs it, and as that just hit mainline, it's a bit unfair
to state that no distro uses it (and I think that it's even untrue, look
for the distros that ship ocfs2...)

thanks,

greg k-h
