Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288715AbSADSa0>; Fri, 4 Jan 2002 13:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288714AbSADSaQ>; Fri, 4 Jan 2002 13:30:16 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7941 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288716AbSADSaG>; Fri, 4 Jan 2002 13:30:06 -0500
Subject: Re: PATCH 2.5.2.7: io.h cleanup and userspace nudge
To: dwmw2@infradead.org (David Woodhouse)
Date: Fri, 4 Jan 2002 18:39:49 +0000 (GMT)
Cc: davej@suse.de (Dave Jones), jgarzik@mandrakesoft.com (Jeff Garzik),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Linux-Kernel list)
In-Reply-To: <20922.1010168405@redhat.com> from "David Woodhouse" at Jan 04, 2002 06:20:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16MZFt-000548-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just putting it asm-*/types.h should just about be enough.

That is one of the headers glibc wants to import however. It wants to be
hard for applications to do something stupid  but easy for glibc to extract
the relevant data that it actually needs (because glibc needs the kernel to
user information to make syscalls even if it doesnt expose them to apps)

Alan

