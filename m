Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265078AbSJWRWX>; Wed, 23 Oct 2002 13:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265103AbSJWRWX>; Wed, 23 Oct 2002 13:22:23 -0400
Received: from chaos.analogic.com ([204.178.40.224]:31366 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265078AbSJWRWV>; Wed, 23 Oct 2002 13:22:21 -0400
Date: Wed, 23 Oct 2002 13:31:09 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Torrey Hoffman <thoffman@arnor.net>
cc: "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Roskin <proski@gnu.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: "Hearty AOL" for kexec
In-Reply-To: <1035392282.30561.85.camel@rivendell.arnor.net>
Message-ID: <Pine.LNX.3.95.1021023132644.14975A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Oct 2002, Torrey Hoffman wrote:

> On Wed, 2002-10-23 at 08:03, Eric W. Biederman wrote:
> > Pavel Roskin <proski@gnu.org> writes:
> [...]
> > > I really want to see this feature in the kernel.  It is very useful in
> > > embedded systems.  Just imagine loading the bootstrap kernel, then
> > > downloading the new kernel over anything - HDLC, 802.11, USB, decrypting
> > > it from flash etc.  Possibilities are infinite.
> > 
> > Yay!!!!  My first embedded developer who doesn't think it is silly to
> > use a kernel as a bootloader :)  Or at least the first to admit they
> > embedded developer.
> 
> Yeah, another AOL "Me Too" here - I'm an embedded linux developer and
> think would be useful.  Being able to network boot the device, download
> software to a flash, and then directly "kexec" boot from the kernel on
> the flash would be nice. 
> 
> Anything that reduces dependencies on the BIOS is good.  I'd use this
> feature if it was available.

But 'downloading' (actually uploading) software and writing it to
flash for a re-boot is a trivial user-mode task. The actual boot
from such a virtual disk takes 4 seconds on a real system (AMD SC520)
processor in an embedded system. You don't need any special kernel
hooks.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


