Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131256AbQL1VCi>; Thu, 28 Dec 2000 16:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130882AbQL1VC3>; Thu, 28 Dec 2000 16:02:29 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:29969 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131744AbQL1VCV>; Thu, 28 Dec 2000 16:02:21 -0500
Date: Thu, 28 Dec 2000 16:39:27 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre5
In-Reply-To: <Pine.LNX.4.10.10012281220470.17769-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0012281637200.12364-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Dec 2000, Linus Torvalds wrote:

> This still doesn't tell "sync()" about dirty pages (ie the "innd loses the
> active file after a reboot" bug), but now the places that mark pages dirty
> are under control. Next step..

Do you really want to split the per-address-space pages list in dirty and
clean lists for 2.4 ?

Or do you think walking the current per-address-space page list searching
for dirty pages and syncing them is ok?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
