Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131407AbREHKgm>; Tue, 8 May 2001 06:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131480AbREHKgd>; Tue, 8 May 2001 06:36:33 -0400
Received: from mail.inf.elte.hu ([157.181.161.6]:30094 "HELO mail.inf.elte.hu")
	by vger.kernel.org with SMTP id <S131407AbREHKgX>;
	Tue, 8 May 2001 06:36:23 -0400
Date: Tue, 8 May 2001 12:36:18 +0200 (CEST)
From: BERECZ Szabolcs <szabi@inf.elte.hu>
To: "David S. Miller" <davem@redhat.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() bug
In-Reply-To: <15095.26644.491818.92403@pizda.ninka.net>
Message-ID: <Pine.A41.4.31.0105081216350.76998-100000@pandora.inf.elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 May 2001, David S. Miller wrote:

> My patch is crap and can cause corruptions, there is not argument
> about it now :-)
is it the only bug in the swap handling?
or why is this bug triggered so heavily if the swap is on a filesystem?
I had oopses when I used a swapfile on a partition, but that was really
rare. I even don't think it's becouse page_launder().
so what's so different if the swap sits on a filesystem?

Bye,
Szabi


