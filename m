Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292107AbSBOLXD>; Fri, 15 Feb 2002 06:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292108AbSBOLWu>; Fri, 15 Feb 2002 06:22:50 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:11533 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S292107AbSBOLWr>; Fri, 15 Feb 2002 06:22:47 -0500
Date: Fri, 15 Feb 2002 12:25:33 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, <davidm@hpl.hp.com>,
        "David S. Miller" <davem@redhat.com>, <anton@samba.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] move task_struct allocation to arch
In-Reply-To: <3C6CDB4D.D072A7B4@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0202151219590.564-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 15 Feb 2002, Jeff Garzik wrote:

> > any extra clock cycles. This led to Linus requesting that everything that
> > entry.S needs to access be separated out into another structure (so that
> > entry.S never accesses task_struct).
>
> Seems a sane enough direction...

That wouldn't be a problem, if ia32 added the needed infrastructure to
calculate the structure offsets. It's not really that difficult, look at
the m68k implementation, which even gets dependencies right. AFAIK Keith
also added the needed infra structure to his new build system.

bye, Roman

