Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267137AbSLKNXc>; Wed, 11 Dec 2002 08:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267139AbSLKNXc>; Wed, 11 Dec 2002 08:23:32 -0500
Received: from [66.70.28.20] ([66.70.28.20]:4875 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S267137AbSLKNXa>; Wed, 11 Dec 2002 08:23:30 -0500
Date: Wed, 11 Dec 2002 13:32:51 +0100
From: DervishD <raul@pleyades.net>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [BK-2.4] [PATCH] Small do_mmap_pgoff correction
Message-ID: <20021211123251.GA48@DervishD>
References: <20021210221357.GA46@DervishD> <20021210.141451.66294590.davem@redhat.com> <20021210222842.GA64@DervishD> <20021210.170644.97772177.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021210.170644.97772177.davem@redhat.com>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi David :)

>        Perfect :) If you want, I can make the patch and tell to Alan and
>    Linus. Anyway, I think you will better heared than me O:))
> If you could take care of this, I would really be happy.

    OK, then, I'll prepare the patch.

>        Anyway, I'll take a look at a new macro (lets say PAGE_ALIGN_SIZE
>    or something as ugly as this ;)))
> How many places do we try to apply PAGE_ALIGN to a length?
> If it's just one or two spots, perhaps the special macro
> isn't worthwhile.

    I've seen four or five, without a detailed examination. Anyway,
since it would be a dangerous change (being in the MM code), I'll
count ocurrences and problems. There is no intrinsic problem in using
PAGE_ALIGN on a size if we know that size is small enough.

    Thanks for all, Dave :)
    Raúl
