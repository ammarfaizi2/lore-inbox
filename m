Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbTLWXnJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 18:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbTLWXnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 18:43:09 -0500
Received: from mail.kroah.org ([65.200.24.183]:19089 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262765AbTLWXnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 18:43:06 -0500
Date: Tue, 23 Dec 2003 15:26:34 -0800
From: Greg KH <greg@kroah.com>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] some sysfs patches for 2.6.0 [0/4]
Message-ID: <20031223232634.GE16315@kroah.com>
References: <20031223002126.GA4805@kroah.com> <pan.2003.12.23.11.07.41.714913@dungeon.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2003.12.23.11.07.41.714913@dungeon.inka.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 12:07:43PM +0100, Andreas Jellinghaus wrote:
> On Tue, 23 Dec 2003 00:42:03 +0000, Greg KH wrote:
> 
> > Here are 4 sysfs related patches for 2.6.0. 
> 
> Thanks, thoses added many missing devices.
> 
> Are there usable patches to add these? url?
>  - floppy devices (propably not necessary)

Already in the main kernel, all block devices are supported.

>  - alsa sound devices (snd/ and sound/ (oss emulation))

Working on it right now.

>  - input devices

Hanna Linder has been working on this, but I think she's on vacation
right now.

>  - printer devices

USB printers are already supported :)

No, no parallel port support yet.  I thought Hanna had a patch
somewhere.  The "simple_class" patch I just posted should make it pretty
easy to add support for this if you want to try it.

thanks,

greg k-h
