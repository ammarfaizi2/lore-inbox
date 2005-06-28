Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVF1VSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVF1VSo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 17:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVF1VRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 17:17:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:13195 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261269AbVF1VIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 17:08:05 -0400
Date: Tue, 28 Jun 2005 23:08:04 +0200
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Greg KH <greg@kroah.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
Message-ID: <20050628210804.GA26713@suse.de>
References: <20050624081808.GA26174@kroah.com> <9EE4350F-5791-4787-950B-14E5C2B9ADB8@mac.com> <20050628074145.GC3577@kroah.com> <20050628195633.GA26131@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20050628195633.GA26131@smtp.west.cox.net>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Jun 28, Tom Rini wrote:

> On Tue, Jun 28, 2005 at 12:41:45AM -0700, Greg KH wrote:
> > On Fri, Jun 24, 2005 at 08:57:55PM -0400, Kyle Moffett wrote:
> > > One of the things that most annoys me about udev is that I still need
> > > a minimal static dev in order for the system to boot.
> > 
> > Why?  You should not.  Works just fine for me here :)
> 
> Er, don't you need /dev/console for console output to happen? (And that
> it's a good idea to have /dev/null around too).  Or has that changed?

scripts/gen_initramfs_list.sh creates that for every kernel.
