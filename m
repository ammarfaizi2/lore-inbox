Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280820AbRKTBuV>; Mon, 19 Nov 2001 20:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280825AbRKTBuK>; Mon, 19 Nov 2001 20:50:10 -0500
Received: from ws-002.ray.fi ([193.64.14.2]:50027 "EHLO behemoth.ts.ray.fi")
	by vger.kernel.org with ESMTP id <S280820AbRKTBuB>;
	Mon, 19 Nov 2001 20:50:01 -0500
Date: Tue, 20 Nov 2001 03:48:00 +0200 (EET)
From: Tommi Kyntola <kynde@ts.ray.fi>
X-X-Sender: <lk@behemoth.ts.ray.fi>
To: Rik van Riel <riel@conectiva.com.br>
cc: Ryan Cumming <bodnar42@phalynx.dhs.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.15-pre6 / EXT3 / ls shows '.journal' on root-fs.
In-Reply-To: <Pine.LNX.4.33L.0111192340500.4079-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.33.0111200344080.1395-100000@behemoth.ts.ray.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Since what's there to stop you from 'chattr -i .journal ; rm .journal'.
> 
> man 1 lart

:-) naturally

But still, I didnt chattr it to non immutable and rm is something
that the tmp sweeps would do for a .journal file in /tmp anyway.
So it's a pretty typical scenario. 

What I'm wondering is that wether removing it is has any intended (or 
otherwise) consequences?

-- 
  Tommi "Kynde" Kyntola      
     /* A man alone in the forest talking to himself and 
        no women around to hear him. Is he still wrong?  */


