Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263081AbSJOGww>; Tue, 15 Oct 2002 02:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263039AbSJOGww>; Tue, 15 Oct 2002 02:52:52 -0400
Received: from [195.39.17.254] ([195.39.17.254]:5636 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S263173AbSJOGwu>;
	Tue, 15 Oct 2002 02:52:50 -0400
Date: Mon, 14 Oct 2002 18:33:13 +0200
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Input - Make i8042.c less picky about AUX ports [1/3]
Message-ID: <20021014183313.B585@elf.ucw.cz>
References: <200210100725.JAA00155@bug.ucw.cz> <20021010093631.A7994@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021010093631.A7994@ucw.cz>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > ChangeSet@1.597.3.1, 2002-10-08 17:36:32+02:00, vojtech@suse.cz
> > >   Make i8042.c even less picky about detecting an AUX port because of
> > >   broken chipsets that don't support the LOOP command or report failure
> > >   on the TEST command. Hopefully this won't screw any old 386/486
> > >   systems without the AUX port.
> > 
> > would it make sense to at least printk() on such
> > broken chipsets? 
> 
> Maybe. But if we wanted to printk() on every chipset which doesn't
> follow the i8042 spec in some way, we'd keep the logs full ...

If you keep it one line per bug, it should not be more than 2 lines on
normal chipsets, right? :-). And we may get better hardware in future
by doing this.
								Pavel
-- 
When do you have heart between your knees?
