Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276654AbRJPT7B>; Tue, 16 Oct 2001 15:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276665AbRJPT6w>; Tue, 16 Oct 2001 15:58:52 -0400
Received: from ns.caldera.de ([212.34.180.1]:20972 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S276654AbRJPT6l>;
	Tue, 16 Oct 2001 15:58:41 -0400
Date: Tue, 16 Oct 2001 21:59:08 +0200
Message-Id: <200110161959.f9GJx8T03152@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: juhl@eisenstein.dk (Jesper Juhl)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] various minor cleanups against 2.4.13-pre3 - comments requested
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <3BCC8C88.58BBCC39@eisenstein.dk>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3BCC8C88.58BBCC39@eisenstein.dk> you wrote:
> kernel/exec_domain.c :
>         Contrary to most other files in the kernel source the functions
> in exec_domain.c are defined with the
>         return values on a line by themselves. Most places in kernel
> source have the entire function definition
>         on a single line (as long as it does not exceed 80 chars in
> length). So I moved the function definitions
>         onto a single line.

NO.  This file is maintained and that style is intentional.
(BTW, you could compare it to output of scripts/Lindent..)


> kernel/exec_domain.c : get_exec_domain_list()
>         The len variable (signed) is compared to PAGE_SIZE (unsigned).
> Changing len to "unsigned int" avoids
>         comparison between signed and unsigned.

Looks sane to me.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
