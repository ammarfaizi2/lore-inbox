Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271178AbTGPWrP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 18:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271183AbTGPWqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 18:46:37 -0400
Received: from 224.Red-217-125-129.pooles.rima-tde.net ([217.125.129.224]:3574
	"HELO cocodriloo.com") by vger.kernel.org with SMTP id S271181AbTGPWo5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 18:44:57 -0400
Date: Thu, 17 Jul 2003 00:39:35 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pavel Machek <pavel@suse.cz>,
       Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       root@mauve.demon.co.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend on one machine, resume elsewhere [was Re: [Swsusp-devel] RE:Re: Thoughts wanted on merging Softwa]
Message-ID: <20030716223935.GF2684@wind.cocodriloo.com>
References: <20030716083758.GA246@elf.ucw.cz> <200307161037.LAA01628@mauve.demon.co.uk> <20030716104026.GC138@elf.ucw.cz> <20030716195129.A9277@informatik.tu-chemnitz.de> <20030716181551.GD138@elf.ucw.cz> <1058383043.6600.53.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058383043.6600.53.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 08:17:24PM +0100, Alan Cox wrote:
> On Mer, 2003-07-16 at 19:15, Pavel Machek wrote:
> > Hi!
> > 
> > > > If you want to migrate programs between machines, run UMLinux, same
> > > > config, on both machines. Ouch and you'll need swsusp for UMLinux, too
> > > 
> > > That might be more important than you think.
> > 
> > :-). Well, it is also harder than you probably think, because UML is
> > *very* strange architecture and it is not at all easy to save/restore
> > its state. There were some patches in that area, but it never worked
> > (AFAIK).
> 
> Would it not be a lot easier to tackle that with qemu, and teach qemu to
> freeze/restore virtual machines ?

AFAIK, qemu does virtual processes, but not virtual machines. Running init(1)
from qemu could be fun, anyways ;)

Greets, Antonio.
 
-- 

In fact, this is all you need to know to be
a Caveman Database Programmer:

A relational database is a big spreadsheet
that several people can update simultaneously. 

