Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129805AbQKTCkY>; Sun, 19 Nov 2000 21:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129960AbQKTCkP>; Sun, 19 Nov 2000 21:40:15 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:24327 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129805AbQKTCkL>; Sun, 19 Nov 2000 21:40:11 -0500
Date: Mon, 20 Nov 2000 03:09:39 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Josue Emmanuel Amaro <Josue.Amaro@oracle.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Value of TASK_UNMAPPED_SIZE on 2.4
Message-ID: <20001120030939.C21625@athlon.random>
In-Reply-To: <fa.d4dt9vv.1gm6abv@ifi.uio.no> <fa.ebii26v.1mgevrq@ifi.uio.no> <80snp8reck.fsf@orthanc.exbit-technology.com> <20001103214613.C17349@athlon.random> <3A033DE6.F4CD60C1@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A033DE6.F4CD60C1@oracle.com>; from Josue.Amaro@oracle.com on Fri, Nov 03, 2000 at 02:36:22PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2000 at 02:36:22PM -0800, Josue Emmanuel Amaro wrote:
> Andrea,
> 
> We will give it a try.
> 
> How difficult would it be to move that patch to 2.4?

I moved it to 2.4.0-test11-pre5 (should work with pre7 too):

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.0-test11-pre5/per-process-3.5G-IA32-no-PAE-1

It won't work with PAE enabled though (64G option). Making it to work with PAE
enabled isn't much more complicated and I'll address that later (but
in the meantime you can use it on <= 4GB RAM machines).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
