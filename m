Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318353AbSGYG3R>; Thu, 25 Jul 2002 02:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318354AbSGYG3R>; Thu, 25 Jul 2002 02:29:17 -0400
Received: from www.transvirtual.com ([206.14.214.140]:14598 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S318353AbSGYG3R>; Thu, 25 Jul 2002 02:29:17 -0400
Date: Wed, 24 Jul 2002 23:32:09 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [PATCH] Second set of console changes.
In-Reply-To: <20020724225835.H25115@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207242326520.29650-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wed, Jul 24, 2002 at 01:08:33PM -0700, James Simmons wrote:
> >  drivers/char/sysrq.c           |  486 ----
>
> Do you really mean to remove _all_ sysrq functionality from the kernel,
> thereby removing an important debugging feature?

Oops. I forgot to do a bk -r co -q after the push. Will send out a newer
patch. Also I discovered a few missed files with the handle_sysrq change.
New patch in the works.

P.S

   To the people with the devfs issues. Please send me a log of what
exactly happened and a detail ksymoop if you can. I just tried it on my
system with devfs enabled and it works for me.

