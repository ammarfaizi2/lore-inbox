Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271050AbTGPTFQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 15:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271051AbTGPTFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 15:05:16 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:38091
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S271050AbTGPTFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 15:05:08 -0400
Subject: Re: Suspend on one machine, resume elsewhere [was Re:
	[Swsusp-devel] RE:Re: Thoughts wanted on merging Softwa]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>, root@mauve.demon.co.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030716181551.GD138@elf.ucw.cz>
References: <20030716083758.GA246@elf.ucw.cz>
	 <200307161037.LAA01628@mauve.demon.co.uk> <20030716104026.GC138@elf.ucw.cz>
	 <20030716195129.A9277@informatik.tu-chemnitz.de>
	 <20030716181551.GD138@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058383043.6600.53.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Jul 2003 20:17:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-16 at 19:15, Pavel Machek wrote:
> Hi!
> 
> > > If you want to migrate programs between machines, run UMLinux, same
> > > config, on both machines. Ouch and you'll need swsusp for UMLinux, too
> > 
> > That might be more important than you think.
> 
> :-). Well, it is also harder than you probably think, because UML is
> *very* strange architecture and it is not at all easy to save/restore
> its state. There were some patches in that area, but it never worked
> (AFAIK).

Would it not be a lot easier to tackle that with qemu, and teach qemu to
freeze/restore virtual machines ?

