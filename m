Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265506AbTBTMip>; Thu, 20 Feb 2003 07:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265517AbTBTMhD>; Thu, 20 Feb 2003 07:37:03 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:8209 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S265506AbTBTMgW>; Thu, 20 Feb 2003 07:36:22 -0500
Date: Thu, 20 Feb 2003 13:46:22 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       <wa@almesberger.net>
Subject: Re: [RFC] Is an alternative module interface needed/possible?
In-Reply-To: <200302201209.EAA12261@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.44.0302201337000.1336-100000@serv>
References: <200302201209.EAA12261@adam.yggdrasil.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 20 Feb 2003, Adam J. Richter wrote:

> 	The ability to remove a module is generally independent of
> whether or not there is any hardware present at that moment for which
> the module supplies a driver.  Instead, the determining issue is
> whether there are file descriptors open for that driver.

I don't understand, what you're trying to say.
File descriptors are not the only way to access a driver and the ability 
to remove a module is only dependent on the number of references to this 
module.

bye, Roman

