Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265316AbSJaT7U>; Thu, 31 Oct 2002 14:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265309AbSJaT5u>; Thu, 31 Oct 2002 14:57:50 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:37031 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S265302AbSJaT5j> convert rfc822-to-8bit; Thu, 31 Oct 2002 14:57:39 -0500
Date: Thu, 31 Oct 2002 17:27:30 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: =?iso-8859-1?Q?J=2EA=2E_Magall=F3n?= <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Pending bugfixes for 2.4.20 ?
In-Reply-To: <20021031002705.GA3587@werewolf.able.es>
Message-ID: <Pine.LNX.4.44L.0210311724500.13346-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


JA,

Would you mind sending each one of this updates to linux-kernel CC me in
separate emails ?

I should have applied Dave Jones patch before (it has been around for a
while), but now its too late.

Maybe Ingo's fix to crashes with CLONE_DETACHED threads is suitable for
-rc2.

Anyway, I'll save the ones which are not suitable for -rc1 in my pending
fixes list.

Thanks

On Thu, 31 Oct 2002, J.A. Magallón wrote:

> Hi all.
>
> We are in -rc, so only bugfixes ;)
> I have this collection of things posted in LKML as bugfixes, that still
> apply on top of rc1. Could you include if appropiate for next -rc, plz ?
>
> List:
>
> 02-printk
>     Kill extra printk declaration.
>     Author: David Howells <dhowells@redhat.com>
>
> 03-clone-detached
>     Fix a crash that can be caused by a CLONE_DETACHED thread.
>     Author: Ingo Molnar <mingo@elte.hu>
>
> 04-module-size-checks
>     Fixes two minor bugs in kernel/module.c related with module size checks.
>     Author: Peter Oberparleiter <oberpapr@softhome.net>
>
> 06-memparam
>     Fix mem=XXX kernel parameter when user gives a size bigger than what
>     kernel autodetected (kill a previous change)
>     Author: Adrian Bunk <bunk@fs.tum.de>,
>             Leonardo Gomes Figueira <sabbath@planetarium.com.br>
>
> 07-cache-detection
>     Fix cache detection, adds trace cache detection.
>     Author: Dave Jones <davej@codemonkey.org.uk>
>
> 08-highpage-init
>     Cleanup one_highpage_init() as in 2.5.
>     Author: Christoph Hellwig <hch@sgi.com>
>
> 09-self_exec_id
>     Fix bad signaling between threads when ancestor dies.
>     Author: Zeuner, Axel <Axel.Zeuner@partner.commerzbank.com>
>
> If somebody has anything to say, or has updated versions...
>
> TIA
>
> --
> J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
> werewolf.able.es                         \           It's better when it's free
> Mandrake Linux release 9.1 (Cooker) for i586
> Linux 2.4.20-rc1-jam0 (gcc 3.2 (Mandrake Linux 9.0 3.2-2mdk))
>

