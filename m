Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136661AbREARH3>; Tue, 1 May 2001 13:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136662AbREARHJ>; Tue, 1 May 2001 13:07:09 -0400
Received: from chromium11.wia.com ([207.66.214.139]:30219 "EHLO
	neptune.kirkland.local") by vger.kernel.org with ESMTP
	id <S136661AbREARG6>; Tue, 1 May 2001 13:06:58 -0400
Message-ID: <3AEEEE1D.F0C4F1F6@chromium.com>
Date: Tue, 01 May 2001 10:10:53 -0700
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christopher Smith <x@xman.org>, Andrew Morton <andrewm@uow.edu.au>,
        "Timothy D. Witham" <wookie@osdlab.org>, David_J_Morse@Dell.com
Subject: Re: X15 alpha release: as fast as TUX but in user space
In-Reply-To: <Pine.LNX.4.33.0105011047540.4266-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is actually a bug in the current X15, I know how to fix it (with
negligible overhead) but I've been lazy :)

give me a few days...

 - Fabio

Ingo Molnar wrote:

> hm, another X15 caching artifact i noticed: i've changed the index.html
> file, and while X15 was still serving the old copy, TUX served the new
> file immediately.
>
> its cache is apparently not coherent with actual VFS contents. (ie. it's a
> read-once cache apparently?) TUX has some (occasionally significant)
> overhead due to non-cached VFS-lookups.
>
>         Ingo
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

