Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268838AbUJPUIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268838AbUJPUIH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 16:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268817AbUJPUGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 16:06:07 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:53861 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S268831AbUJPUEY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 16:04:24 -0400
Date: Sun, 17 Oct 2004 00:04:27 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dan Kegel <dank@kegel.com>, Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Schaffner <schaffner@gmx.li>, Kevin Hilman <kjh@hilman.org>,
       bertrand marquis <bertrand.marquis@sysgo.com>
Subject: Re: Building on case-insensitive systems and systems where -shared doesn't work well (was: Re: 2.6.8 link failure for sparc32 (vmlinux.lds.s: No such file or directory)?)
Message-ID: <20041016220427.GE8765@mars.ravnborg.org>
Mail-Followup-To: Dan Kegel <dank@kegel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Martin Schaffner <schaffner@gmx.li>, Kevin Hilman <kjh@hilman.org>,
	bertrand marquis <bertrand.marquis@sysgo.com>
References: <414FC41B.7080102@kegel.com> <58517.194.237.142.24.1095763849.squirrel@194.237.142.24> <4164DAC9.8080701@kegel.com> <20041016210024.GB8306@mars.ravnborg.org> <20041016200627.A20488@flint.arm.linux.org.uk> <20041016212440.GA8765@mars.ravnborg.org> <20041016204001.B20488@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041016204001.B20488@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2004 at 08:40:01PM +0100, Russell King wrote:
> On Sat, Oct 16, 2004 at 11:24:40PM +0200, Sam Ravnborg wrote:
> > On Sat, Oct 16, 2004 at 08:06:27PM +0100, Russell King wrote:
> > > 
> > > Converting .S -> .s is useful for debugging - please don't cripple the
> > > kernel developers just because some filesystems are case-challenged.
> > 
> > Does the debug tools rely on files named *.s then?
> > 
> > There are today ~1400 files named *.S in the tree, but none named *.s.
> > So my idea was to do it like:
> > *.S => *.asm => *.o
> > But if this breaks some debugging tools I would like to know.
> 
> *.asm is nonstanard naming.  If we have to support case-challenged
> filesystems, please ensure that the rest of the nonbroken world can
> continue as they have done for the last few decades and live happily
> unaffected by these problems.

I still do not see how a kernel developer are affected by changing
the extension of an intermidiate file - please explain.

	Sam
