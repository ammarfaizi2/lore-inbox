Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129627AbQKTOJa>; Mon, 20 Nov 2000 09:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131615AbQKTOJU>; Mon, 20 Nov 2000 09:09:20 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:63986 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129627AbQKTOJH>; Mon, 20 Nov 2000 09:09:07 -0500
Date: Mon, 20 Nov 2000 11:38:38 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Ville Herva <vherva@mail.niksula.cs.hut.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blindingly stupid 2.2 VM bug
In-Reply-To: <20001119100100.A54301@niksula.cs.hut.fi>
Message-ID: <Pine.LNX.4.21.0011201135590.4587-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2000, Ville Herva wrote:

> My questions is: I saw Andrea's VM-global patch being
> recommended as a solution for this problem, and I already
> compiled it in (although I haven't booted into it yet). Should I
> use Rik's or Andrea's patch?

This patch is incremental with VM-global, but that's
only because the Conectiva kernel RPM happens to
contain VM-global, not because I agree with all points
of VM-global (some of the changes seem a bit .. suspect).

Luckily my patch fixes some of the suspect areas in
VM-global and most of the other parts of VM-global make
a lot of sense. It's not perfect, but it should be good
enough for 2.2.

On whether any of these improvements are going into the
next 2.2, don't bother asking me since I have no intention
paying much attention to 2.2 and I was only needing it to
install a machine with ext3...

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
