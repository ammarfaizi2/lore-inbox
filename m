Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263231AbUJ2Kli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263231AbUJ2Kli (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 06:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263233AbUJ2Kli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 06:41:38 -0400
Received: from sd291.sivit.org ([194.146.225.122]:1239 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S263232AbUJ2KkN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 06:40:13 -0400
Date: Fri, 29 Oct 2004 12:41:39 +0200
From: Stelian Pop <stelian@popies.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 4/8] sonypi: rework input support
Message-ID: <20041029104138.GA3222@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Pavel Machek <pavel@ucw.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20041028100525.GA3893@crusoe.alcove-fr> <20041028100823.GE3893@crusoe.alcove-fr> <20041029101050.GA1183@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029101050.GA1183@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 12:10:50PM +0200, Pavel Machek wrote:

> > +	{ SONYPI_EVENT_FNKEY_F1, 		KEY_FN_F1 },
> > +	{ SONYPI_EVENT_FNKEY_F2, 		KEY_FN_F2 },
> > +	{ SONYPI_EVENT_FNKEY_F3, 		KEY_FN_F3 },
[...]

> KEY_FN_D does not sound too usefull (similar for FN_F1..FN_F12). Are
> there some pictures on those keys? 

Some of them have pictures (Fn-Esc for suspend to ram, Fn-F12 for
suspend to disk, Fn-F3 for mute, Fn-F4 for launching the volume
controls, Fn-F5 for launching the brightness controls, Fn-F7/F8 for
changing from LCD to external monitor or TV). All the others have
no pictures on them.

> Mapping FN_F3 to for example
> KEY_SUSPEND would be usefull...

This sound like policy to me and should not be done into the
kernel but somewhere you can configure it, like in a keyboard 
keymap or something like that.

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
