Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262747AbVCDLFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbVCDLFm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 06:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbVCDLFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 06:05:16 -0500
Received: from ns.suse.de ([195.135.220.2]:31409 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262747AbVCDLCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 06:02:22 -0500
Date: Fri, 4 Mar 2005 12:02:15 +0100
From: Olaf Hering <olh@suse.de>
To: Jeff Mahoney <jeffm@suse.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] openfirmware: adds sysfs nodes for openfirmware	devices
Message-ID: <20050304110215.GC14408@suse.de>
References: <20050301211824.GC16465@locomotive.unixthugs.org> <1109806334.5611.121.camel@gaston> <42275536.8060507@suse.com> <20050303202319.GA30183@suse.de> <42277ED8.6050500@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <42277ED8.6050500@suse.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thu, Mar 03, Jeff Mahoney wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Olaf Hering wrote:
> >  On Thu, Mar 03, Jeff Mahoney wrote:
> > 
> > 
> >>Is whitespace (in any form) allowed in the compatible value?
> > 
> > 
> > Yes, whitespace is used at least in the toplevel compatible file, like
> > 'Power Macintosh' in some Pismo models.
> > 
> 
> Oh well, it was wishful thinking anyway. ;)

The same thing needs to be solved for vio devices, the properties can
contain spaces. depmod and modprobe have to deal with it to generate a
valid module.alias file.
