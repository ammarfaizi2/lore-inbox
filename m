Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266425AbSLDLvK>; Wed, 4 Dec 2002 06:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266433AbSLDLvK>; Wed, 4 Dec 2002 06:51:10 -0500
Received: from [195.39.17.254] ([195.39.17.254]:8196 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S266425AbSLDLvJ>;
	Wed, 4 Dec 2002 06:51:09 -0500
Date: Wed, 4 Dec 2002 12:57:43 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linus <torvalds@transmeta.com>, LKML <linux-kernel@vger.kernel.org>,
       anton@samba.org, "David S. Miller" <davem@redhat.com>, ak@muc.de,
       davidm@hpl.hp.com, schwidefsky@de.ibm.com, ralf@gnu.org,
       willy@debian.org
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
Message-ID: <20021204115743.GA6494@elf.ucw.cz>
References: <20021204180224.406d143c.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021204180224.406d143c.sfr@canb.auug.org.au>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Below is the generic part of the start of the compatibility syscall layer.
> I think I have made it generic enough that each architecture can define
> what compatibility means.
> 
> To use this,an architecture must create asm/compat.h and provide typedefs
> for (currently) compat_time_t, compat_suseconds_t, struct compat_timespec.
					~~~~
					Maybe we need better name?
				This is too easy to missparse ;-).
									Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
