Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130063AbQKVOnH>; Wed, 22 Nov 2000 09:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130073AbQKVOm5>; Wed, 22 Nov 2000 09:42:57 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:29935 "EHLO
        brutus.conectiva.com.br") by vger.kernel.org with ESMTP
        id <S130063AbQKVOmu>; Wed, 22 Nov 2000 09:42:50 -0500
Date: Wed, 22 Nov 2000 12:07:48 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Daniel Stone <daniel@kabuki.eyep.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Rik's bad process killer - how to kill _IT_?
In-Reply-To: <20001122123115Z129851-8303+80@vger.kernel.org>
Message-ID: <Pine.LNX.4.21.0011221205320.12459-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2000, Daniel Stone wrote:

> I've been having a bit of a problem with Rik's new VM, in particular the bad
> process-killer. Basically put, I have a reasonably underpowered system
> (P166) running Helix GNOME & Sawfish, and half the time when I load my Eterm
> (admittedly, transparent, but it looks cool, damnit!), or Netscape (or
> both!) it seems to be Rik's VM killer slaying them. No error message is
> logged anywhere, not even if I start 'em from the console.

> Daniel Stone
> Linux Kernel Developer
  ^^^^^^^^^^^^^^^^^^^^^^

If you were, you'd have written something that makes sense.

1. my OOM killer *always* spits out a message when it kills
   something
2. you haven't written what kernel version you're using;
   judging from your lack of error messages you're running
   2.2 (which has the nasty habit of killing processes under
   heavy load ... I have a patch out which fixes that)

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
