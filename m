Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310858AbSC1AWO>; Wed, 27 Mar 2002 19:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310917AbSC1AWF>; Wed, 27 Mar 2002 19:22:05 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35847 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310816AbSC1AVx>; Wed, 27 Mar 2002 19:21:53 -0500
Subject: Re: DE and hot-swap disk caddies
To: andersen@codepoet.org
Date: Thu, 28 Mar 2002 00:37:45 +0000 (GMT)
Cc: andre@linux-ide.org (Andre Hedrick), josh@stack.nl (Jos Hulzink),
        jw@pegasys.ws (jw schultz), linux-kernel@vger.kernel.org
In-Reply-To: <20020328001709.GA16582@codepoet.org> from "Erik Andersen" at Mar 27, 2002 05:17:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16qNvF-0006Xv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok.  How about my laptop?  I have an ATAPI zip drive I can plug
> in instead of a second battery.  It is the only device on the
> second IDE bus (hdc).  In windows there is a little hotplug
> utility thing one runs before unplugging the zip drive.  In Linux
> I currently have to reboot if I want the ide-floppy driver to see
> the device...  I'm willing to bet that Dell has done mysterious
> stuff to make the electrical part work.  It would sure be nice if
> I could ask the ide driver to kindly re-scan for /dev/hdc now.

I would imagine Dell have stuff there to do electrical isolation, or that
they have parts of the IDE controller built into the actually removable drive 
unit itself. With additional electronics you can safely do IDE hot plugging,
but you do need the electronics and the host co-operation.
