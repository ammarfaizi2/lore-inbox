Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132206AbQLLQ60>; Tue, 12 Dec 2000 11:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132226AbQLLQ6S>; Tue, 12 Dec 2000 11:58:18 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:20238 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S132206AbQLLQ6C>;
	Tue, 12 Dec 2000 11:58:02 -0500
Message-ID: <3A3651F3.7FACB19D@mandrakesoft.com>
Date: Tue, 12 Dec 2000 11:27:31 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Holloway <Nick.Holloway@pyrites.org.uk>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] generic_serial's block_til_ready
In-Reply-To: <Pine.LNX.4.21.0012121643100.27903-100000@panoramix.bitwizard.nl> <915jgg$pbb$1@alfie.demon.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Holloway wrote:
> 
> patrick@bitwizard.nl (Patrick van de Lageweg) writes:
> > This patch renames the block_til_ready of generic serial to
> > gs_block_til_ready.
> >
> > it helps when other modules have a "static block_til_ready" defined when
> > used older modutils.
> 
> Do you mean older than the version specified as being required in
> Documention/CHANGES?
> 
> If so, then I'm not surprised the patch has not been applied (how many
> times have you sent it?).

His patch is a namespace cleanup, which IMHO should be applied...

	Jeff


-- 
Jeff Garzik         |
Building 1024       | These are not the J's you're lookin' for.
MandrakeSoft        | It's an old Jedi mind trick.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
