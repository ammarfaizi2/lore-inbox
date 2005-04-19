Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVDSUTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVDSUTO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 16:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVDSUTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 16:19:14 -0400
Received: from fire.osdl.org ([65.172.181.4]:28562 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261190AbVDSUTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 16:19:08 -0400
Date: Tue, 19 Apr 2005 13:20:47 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: Git Mailing List <git@vger.kernel.org>, linux-kernel@vger.kernel.org,
       sensors@stimpy.netroedge.com
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
In-Reply-To: <20050419194728.GA24367@kroah.com>
Message-ID: <Pine.LNX.4.58.0504191316180.19286@ppc970.osdl.org>
References: <20050419043938.GA23724@kroah.com> <20050419185807.GA1191@kroah.com>
 <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org> <20050419194728.GA24367@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Apr 2005, Greg KH wrote:
> 
> Ok, if you want some practice with "real" merges, feel free to merge from
> the following two trees whenever you are ready:
> 	kernel.org/pub/scm/linux/kernel/git/gregkh/aoe-2.6.git/
> for 11 aoe bugfix patches, and:
> 	kernel.org/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/
> for 13 driver core, sysfs, and debugfs fixes.

Done, pushed out. Can you verify that the end result looks sane to you? I 
just cheched that the diffstat looks similar (mine claims just 108 lines 
changed in aoecmd.c - possibly due to different diff formats).

And yes, my new merge thing seems to have kept the index-cache much better 
up-to-date, allowing an optimized checkout-cache -f -a to work and only 
get the new files.

Pasky? Can you check my latest git stuff, notably read-tree.c and the 
changes to git-pull-script?

		Linus
