Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312374AbSDCTaZ>; Wed, 3 Apr 2002 14:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312379AbSDCTaK>; Wed, 3 Apr 2002 14:30:10 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34821 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312374AbSDCT2O>; Wed, 3 Apr 2002 14:28:14 -0500
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
To: andrea@suse.de (Andrea Arcangeli)
Date: Wed, 3 Apr 2002 20:11:49 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), arjanv@redhat.com (Arjan van de Ven),
        hugh@veritas.com (Hugh Dickins), mingo@redhat.com (Ingo Molnar),
        stelian.pop@fr.alcove.com (Stelian Pop), linux-kernel@vger.kernel.org
In-Reply-To: <20020403201322.E10959@dualathlon.random> from "Andrea Arcangeli" at Apr 03, 2002 08:13:22 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16sqAf-0004JH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The vmalloc_to_page function is been patched into the kernel without any
> special restriction or requirement for such code, there is not a single

Untrue.

> comment about a change of licence (infact it's probably been cut and
> pasted from one of the dozen of device drivers doing that by hand

All of them GPL none of them exporting it to non GPL users. That code is
and always was GPL. Nor is it an interface for random binary authors. That
vmalloc handling code took a lot of work, binary authors can go and write
their own.

> have the agreement Linus can release a new kernel tarball with the new
> licence for all the normal kernel code, i.e. pure GPL. But for the core

Every single line of code I ever submitted to Linus is -pure- GPL. It bears
a GPL header. That includes my part of the vmalloc_to_page work. It has
never been available to non GPL modules. You took code I and many others
own and exposed it as a library for non GPL users. If they use it that way
they are violating copyright law, and they *will* get cease and desist
letters.

Anyone using any code of mine in the kernel with non GPL code does so on
the basis of the legal doctrine of what is or is not a derivative work,
and they do so on their own legal assessment. Taking code I am one of the
authors of and making it convenient for people like veritas to use in non
GPL code is quite different. Its theft plain and simple.

Alan
