Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbTD3MHk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 08:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbTD3MHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 08:07:40 -0400
Received: from chaos.analogic.com ([204.178.40.224]:18831 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262138AbTD3MHj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 08:07:39 -0400
Date: Wed, 30 Apr 2003 08:21:28 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: John Bradford <john@grabjohn.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Bootable CD idea
In-Reply-To: <200304301154.h3UBs0ob000471@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.53.0304300811300.12971@chaos>
References: <200304301154.h3UBs0ob000471@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Apr 2003, John Bradford wrote:

> Just a random idea that occurred to me...
>
> Since the El-Torito bootable CD standard supports multiple floppy
> images on a single CD, it would be possible to write a script that
> takes a .config file, and the source to, say all the -pre and -rc
> versions of a particular kernel, compiles multiple kernels with the
> same .config, and writes a CD with them all on, set to boot from an
> arbitrary disk partition.
>
> It would make:
>
> > > > Foo doesn't work in -rc2
> > > Did it work in -rc1
> > Not sure
>
> E-Mail exchanges a thing of the past.
>
> Note, that as each floppy image is separate, it's not the same as
> trying to cram multiple kernels on a 2.88 MB floppy image, and is
> therefore actually do-able :-).
>
> John.

Well, it's a boot-loader problem that has to be solved in one
of the boot-loader programs like grub or lilo. When booting a
CD, the BIOS is made to 'think' that a CD is a floppy. It
loads the boot-record and jumps to its code. From that point
on, whatever happens is based upon how, what, and where the
boot record and subsequent code executes. With the large
data space available, you could certainly have multiple
operating systems. It's simply a coding problem. If you
want to modify one of the existing boot-loader programs
let me know. I may be able to help, and certainly can test.

FYI I have a bootable CR/ROM (who doesn't), that contains
a limited root file-system with ramdisks that mount on
/tmp and /var. I use this to boot any linux machine and
repair it. It would be nice to be able to select different
operating system versions as well.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

