Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWDCVtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWDCVtE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 17:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWDCVtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 17:49:04 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:4240 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S932327AbWDCVtC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 17:49:02 -0400
Date: Mon, 3 Apr 2006 14:48:20 -0700
From: Greg KH <greg@kroah.com>
To: schierlm@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17-rc1
Message-ID: <20060403214820.GB29414@kroah.com>
References: <Pine.LNX.4.64.0604022037380.3781@g5.osdl.org> <e0r09j$gu5$1@sea.gmane.org> <20060403194727.GD5616@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060403194727.GD5616@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2006 at 08:47:27PM +0100, Russell King wrote:
> On Mon, Apr 03, 2006 at 01:18:12PM +0200, Michael Schierl wrote:
> > Linus Torvalds wrote:
> > 
> > > For the rest of you, there's the tar-balls, patches, and full ChangeLog.
> > 
> > Does not build here:
> > 
> > [...]
> >   LD      arch/i386/lib/built-in.o
> >   CC      arch/i386/lib/bitops.o
> >   AS      arch/i386/lib/checksum.o
> >   CC      arch/i386/lib/delay.o
> >   AS      arch/i386/lib/getuser.o
> >   CC      arch/i386/lib/memcpy.o
> >   AS      arch/i386/lib/putuser.o
> >   CC      arch/i386/lib/strstr.o
> >   CC      arch/i386/lib/usercopy.o
> >   AR      arch/i386/lib/lib.a
> >   GEN     .version
> >   CHK     include/linux/compile.h
> >   UPD     include/linux/compile.h
> >   CC      init/version.o
> >   LD      init/built-in.o
> >   LD      .tmp_vmlinux1
> > kernel/built-in.o:(.data+0x758): undefined reference to `uevent_helper'
> > make: *** [.tmp_vmlinux1] Error 1
> 
> I've reported this bug several times but I seem to be getting absolutely
> no response.  So I submitted it to bugzilla.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=6306
> 
> Feel free to add your voice to that bug to try to get someone to fix it.
> I'm not hopeful though.

Sorry, I've been swamped with other issues this past week.  I'll fix
this later this week when I get the chance.

thanks,

greg k-h
