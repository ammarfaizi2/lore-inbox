Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276468AbRKHQyn>; Thu, 8 Nov 2001 11:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276591AbRKHQyd>; Thu, 8 Nov 2001 11:54:33 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:60687 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S276511AbRKHQyT>; Thu, 8 Nov 2001 11:54:19 -0500
Date: Thu, 8 Nov 2001 14:54:00 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: out_of_memory() heuristic broken for different mem configurations
 (fwd)
In-Reply-To: <Pine.LNX.4.21.0111081319280.1689-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33L.0111081453160.27028-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2001, Marcelo Tosatti wrote:

> I remember Linus had a reasoning for the "scan _ALL_ ptes until
> success" behaviour.

Oh, I agree with that.

The problem is the "if no success, scan ALL ptes again
in an infinite loop" ;)

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

