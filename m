Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131917AbRANJwP>; Sun, 14 Jan 2001 04:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131819AbRANJwF>; Sun, 14 Jan 2001 04:52:05 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:42916 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S131917AbRANJvq>; Sun, 14 Jan 2001 04:51:46 -0500
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: david+validemail@kalifornia.com, linux-kernel@vger.kernel.org
Subject: Re: shmem or swapfs? was: [Patch] make shm filesystem part configurable
In-Reply-To: <200101132014.f0DKEJh153332@saturn.cs.uml.edu>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <200101132014.f0DKEJh153332@saturn.cs.uml.edu>
Message-ID: <m3itnih3eb.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 14 Jan 2001 10:56:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Albert,

"Albert D. Cahalan" <acahalan@cs.uml.edu> writes:

> Admins already know what "tmpfs" means, so you should just call
> your filesystem that. I know it isn't a pretty name, but in the
> interest of reducing confusion, you should use the existing name.
> 
> Don't think of it as just "for /tmp". It is for temporary storage.
> The name is a reminder that you shouldn't store archives in tmpfs.

OK right now I see two alternatives for the name: "tmpfs" for the SUN
admins and "vmfs" for expressing what it does and to be in line with
"ramfs". Any votes?

> Again for compatibility, Sun's size option would be useful.
> 
> -o size=111222333      Size in bytes, rounded up by page size.
> -o size=111222k        Size in kilobytes (base-2 or ISO standard?)
> -o size=111m           Size in megabytes (base-2 or ISO standard?)
> 
> I'd prefer k for ISO standard and K for base-2.
> Of course m isn't millibytes, but that isn't horrible.

No, I would go for base-2 only. That's what we typically mean with K
and M in the IT world. To be case sensitive is IMHO overkill and
confusing.

Greetings
                Christoph 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
