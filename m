Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312350AbSDCTVy>; Wed, 3 Apr 2002 14:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312358AbSDCTVi>; Wed, 3 Apr 2002 14:21:38 -0500
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:56614 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S312350AbSDCTVY>;
	Wed, 3 Apr 2002 14:21:24 -0500
Date: Wed, 3 Apr 2002 20:19:29 +0100 (BST)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: <tigran@einstein.homenet>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrea Arcangeli <andrea@suse.de>,
        Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
        Ingo Molnar <mingo@redhat.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
In-Reply-To: <Pine.LNX.4.33.0204031106420.3004-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0204032017150.1163-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, but isn't it easier to rename _GPL -> _KERNEL (or _INTERNAL) if,
indeed, that is the meaning thereof? Then, in the future, one wouldn't
have to decide on a case by case basis like we had now (and appeal to
Caesar :) because the intention would be clear from the name?

On Wed, 3 Apr 2002, Linus Torvalds wrote:

>
> Well, you're all wrong, bthththt...
>
> Removing the .._GPL() is in this case correct, but not for any of the
> reasons mentioned, but simply because even Ingo agreed that it shouldn't
> be _GPL since it's explicitly meant for drivers that shouldn't have any
> knowledge whatsoever about the VM internals. GPL or not.
>
> The fact that the code was back-ported from 2.5.x and that the _GPL still
> is there too is just a mistake, partly because I've not gotten any updates
> from Ingo..
>
> 		Linus
>
>

