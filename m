Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271013AbTGPSHe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 14:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271021AbTGPSFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 14:05:53 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:34755 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S271041AbTGPSCF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 14:02:05 -0400
Date: Wed, 16 Jul 2003 20:15:52 +0200
From: Pavel Machek <pavel@suse.cz>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: root@mauve.demon.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Suspend on one machine, resume elsewhere [was Re: [Swsusp-devel] RE:Re: Thoughts wanted on merging Softwa]
Message-ID: <20030716181551.GD138@elf.ucw.cz>
References: <20030716083758.GA246@elf.ucw.cz> <200307161037.LAA01628@mauve.demon.co.uk> <20030716104026.GC138@elf.ucw.cz> <20030716195129.A9277@informatik.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716195129.A9277@informatik.tu-chemnitz.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > If you want to migrate programs between machines, run UMLinux, same
> > config, on both machines. Ouch and you'll need swsusp for UMLinux, too
> 
> That might be more important than you think.

:-). Well, it is also harder than you probably think, because UML is
*very* strange architecture and it is not at all easy to save/restore
its state. There were some patches in that area, but it never worked
(AFAIK).

> Just start your Oracle in UML and swsusp. Now start your loadbalancer and start
> a copy of that frozen image as soon, as the load reaches a defined limit and
> kill these images again, if load goes down.

Not *my* Oracle ;-).
									Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
