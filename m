Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317811AbSGPMrS>; Tue, 16 Jul 2002 08:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317814AbSGPMrR>; Tue, 16 Jul 2002 08:47:17 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:2835 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S317811AbSGPMrP>; Tue, 16 Jul 2002 08:47:15 -0400
Date: Tue, 16 Jul 2002 09:49:53 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Andrew Morton <akpm@zip.com.au>
Cc: Jens Axboe <axboe@suse.de>, William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] loop.c oopses
In-Reply-To: <3D33DED8.C5C92C06@zip.com.au>
Message-ID: <Pine.LNX.4.44L.0207160948160.3009-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jul 2002, Andrew Morton wrote:

> That's maybe wrong - if there are a decent number of pages
> under writeback then we should be able to just wait it out.
> But it gets tricky with the loop driver...

I wonder if it is possible to exhaust the mempool with
the loop driver requests before getting around to the
requests to the underlying block device(s)...


regards,

Rik
-- 
	http://www.linuxsymposium.org/2002/
"You're one of those condescending OLS attendants"
"Here's a nickle kid.  Go buy yourself a real t-shirt"

http://www.surriel.com/		http://distro.conectiva.com/

