Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270990AbTGPRkI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 13:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270969AbTGPRiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 13:38:19 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:47254 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S270994AbTGPRhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 13:37:13 -0400
Date: Wed, 16 Jul 2003 19:51:29 +0200
To: Pavel Machek <pavel@suse.cz>
Cc: root@mauve.demon.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Suspend on one machine, resume elsewhere [was Re: [Swsusp-devel] RE:Re: Thoughts wanted on merging Softwa]
Message-ID: <20030716195129.A9277@informatik.tu-chemnitz.de>
References: <20030716083758.GA246@elf.ucw.cz> <200307161037.LAA01628@mauve.demon.co.uk> <20030716104026.GC138@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030716104026.GC138@elf.ucw.cz>; from pavel@suse.cz on Wed, Jul 16, 2003 at 12:40:26PM +0200
From: ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser)
X-Spam-Score: -5.0 (-----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19cqRg-0003mi-00*CGjq5/V4L2A*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 12:40:26PM +0200, Pavel Machek wrote:
> If you want to migrate programs between machines, run UMLinux, same
> config, on both machines. Ouch and you'll need swsusp for UMLinux, too

That might be more important than you think.

Just start your Oracle in UML and swsusp. Now start your loadbalancer and start
a copy of that frozen image as soon, as the load reaches a defined limit and
kill these images again, if load goes down.

There might be even more interesting scenarios like this.

Regards

Ingo Oeser
