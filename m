Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286594AbRL0UPp>; Thu, 27 Dec 2001 15:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286603AbRL0UPf>; Thu, 27 Dec 2001 15:15:35 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64522 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286594AbRL0UPR>; Thu, 27 Dec 2001 15:15:17 -0500
Date: Thu, 27 Dec 2001 12:12:54 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Richard Gooch <rgooch@ras.ucalgary.ca>, <linux-kernel@vger.kernel.org>
Subject: Re: The direction linux is taking
In-Reply-To: <Pine.LNX.4.33L.0112271802130.12225-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0112271210250.1167-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Dec 2001, Rik van Riel wrote:
> > came out, and emailed me when the patch no longer applies.
>
> ... or compiles, or applies with an offset

Good.

We actually talked inside Transmeta about doing a lot of this automation
centralized (and OSDL took up some of that idea), but yes, from a resource
usage sanity standpoint this is something that _trivially_ can be done at
the sending side, and thus scales out perfectly (while trying to do it at
the receiving end requires some _mondo_ hardware that definitely doesn't
scale, especially for the "compiles cleanly" part).

		Linus

