Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273688AbRIQUOX>; Mon, 17 Sep 2001 16:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273685AbRIQUON>; Mon, 17 Sep 2001 16:14:13 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:3593 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S273683AbRIQUNy>; Mon, 17 Sep 2001 16:13:54 -0400
Date: Mon, 17 Sep 2001 15:49:44 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>, Christoph Rohland <cr@sap.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.4.10pre VM changes: Potential race
In-Reply-To: <Pine.LNX.4.21.0109151236270.1155-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0109171547290.6640-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 15 Sep 2001, Hugh Dickins wrote:

> Marcelo,
> 
> I've done little testing of patch below (just SMP build on UP machine),
> and uncertain whether I'll be able to do more over the weekend.  Better
> for me to think backwards and forwards over it instead.  Please check
> it out and give it a try, or take pieces for a patch of your own.
> I won't be online, but will fetch mail from time to time.
> 
> It's an all-in-one patch of various things, which I'd want to
> divide up into separate parts if I were submitting to Linus.
> There's something in Documentation should be updated too.

Hugh, 

I agree on that we should separate parts if submitting to Linus.


I'm going to separate the parts of the patch which are dealing with the
race we discussed last week, review it, test it, and then send to Linus.


