Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbTKLNbF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 08:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbTKLNbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 08:31:05 -0500
Received: from gaia.cela.pl ([213.134.162.11]:30729 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S262066AbTKLNbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 08:31:03 -0500
Date: Wed, 12 Nov 2003 14:30:49 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Linus Torvalds <torvalds@osdl.org>, Solar Designer <solar@openwall.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-pre9 ide+XFree+ptrace=Complete hang
In-Reply-To: <Pine.LNX.4.44.0311121204140.26451-100000@gaia.cela.pl>
Message-ID: <Pine.LNX.4.44.0311121421450.31972-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Nov 2003, Maciej Zenczykowski wrote:

> On Tue, 11 Nov 2003, Linus Torvalds wrote:
> > A serial console may be easier than a binary search, but either sound like 
> > they should find it.
> Well a binary search did find it - it just took ages... and unfortunately 
> I have no easy way to set up a serial console...

Well I got a hold of the necessary cabling and I'm sorry to report that
there is absolutely nothing on the serial console - I get the boot
messages, etc. fine, the last message before crashing is 'Loglevel set to
9' [invoked by hand via Alt+SysRq+9], after which I crash it with 'strace
ls -lR /' (as a normal user) and nothing else shows up, no oops no nada.  
After it crashed I attempted different Alt+SysRq combos (H/T/M/P/S/U) with
no effect as well - even the help didn't show.  This is still via the
keyboard (not sure how to send a sysrq via serial), although I'm almost
sure now that it wouldn't help - the system is just plain totally 
and completely dead, even the system bios is likely dead - including the 
System Management Mode code (likely responsible for lighting up the LED 
on fn key press/release, which no longer works [although not on every 
crash]).

Cheers,
MaZe.

