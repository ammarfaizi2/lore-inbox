Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313120AbSC1JaP>; Thu, 28 Mar 2002 04:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313119AbSC1JaG>; Thu, 28 Mar 2002 04:30:06 -0500
Received: from vaak.stack.nl ([131.155.140.140]:39174 "HELO mailhost.stack.nl")
	by vger.kernel.org with SMTP id <S313118AbSC1J3r>;
	Thu, 28 Mar 2002 04:29:47 -0500
Date: Thu, 28 Mar 2002 10:29:45 +0100 (CET)
From: Jos Hulzink <josh@stack.nl>
To: Erik Andersen <andersen@codepoet.org>
Cc: Andre Hedrick <andre@linux-ide.org>, jw schultz <jw@pegasys.ws>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: DE and hot-swap disk caddies
In-Reply-To: <20020328001709.GA16582@codepoet.org>
Message-ID: <20020328102239.N5099-100000@toad.stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2002, Erik Andersen wrote:

> Ok.  How about my laptop?  I have an ATAPI zip drive I can plug
> in instead of a second battery.  It is the only device on the
> second IDE bus (hdc).  In windows there is a little hotplug
> utility thing one runs before unplugging the zip drive.  In Linux
> I currently have to reboot if I want the ide-floppy driver to see
> the device...  I'm willing to bet that Dell has done mysterious
> stuff to make the electrical part work.  It would sure be nice if
> I could ask the ide driver to kindly re-scan for /dev/hdc now.
>
> Is whatever windows is doing when I hotplug my zip drive somehow
> unsafe, such that supporting the same functionality on Linux is
> somehow a Bad Thing(tm)?

Erik,

I can't say from here. My guess is that the chipset has an extension to
the ATA standard that allows hot plugging. Your CDrom behaves like a
normal IDE device, which doesn't mean it is one :) For your hotpluggable
device support, we'll need info about the chipset your laptop uses, and
the cdrom drive. Maybe Dell is willing to help us out here.

Jos


