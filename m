Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268773AbTGTWjL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 18:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268836AbTGTWjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 18:39:10 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:37864 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S268773AbTGTWjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 18:39:00 -0400
Date: Mon, 21 Jul 2003 00:53:43 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jan Rychter <jan@rychter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suspend on one machine, resume elsewhere
Message-ID: <20030720225342.GA866@elf.ucw.cz>
References: <20030716083758.GA246@elf.ucw.cz> <200307161037.LAA01628@mauve.demon.co.uk> <20030716104026.GC138@elf.ucw.cz> <20030716195129.A9277@informatik.tu-chemnitz.de> <20030716181551.GD138@elf.ucw.cz> <m2r84m8jhh.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2r84m8jhh.fsf@tnuctip.rychter.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > If you want to migrate programs between machines, run UMLinux, same
>  > config, on both machines. Ouch and you'll need swsusp for UMLinux,
>  > too
>  >>
>  >> That might be more important than you think.
> 
>  Pavel> :-). Well, it is also harder than you probably think, because
>  Pavel> UML is *very* strange architecture and it is not at all easy to
>  Pavel> save/restore its state. There were some patches in that area,
>  Pavel> but it never worked (AFAIK).
> 
> ... but there are many people who dream about swsusp for UMLinux.
> 
> Particularly some laptop users who want to suspend (at least the most
> critical long-running applications) and/or find Linux way too unstable
> and requiring frequent reboots.
> 
> The day UMLinux gets swsusp, I'm moving my XEmacs, mozilla and some
> other toys into a UML machine and staying there. Hopefully then a single
> problem with a USB driver, keventd running wild, or other frequently
> encountered breakage won't be taking my entire world down.

Well, then you may as well help porting swsusp to UML ;-).

OTOH, single problem with suspend *will* then bring your entire world
down :-(. You would be able to rollback, through.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
