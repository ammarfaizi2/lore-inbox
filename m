Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290085AbSAQRsr>; Thu, 17 Jan 2002 12:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290084AbSAQRsh>; Thu, 17 Jan 2002 12:48:37 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:37384 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S290085AbSAQRsZ>;
	Thu, 17 Jan 2002 12:48:25 -0500
Date: Thu, 17 Jan 2002 15:48:10 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Yinlei Yu <yinlei_yu@hotmail.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Is there anyway to use 4M pages on x86 linux in user level?
In-Reply-To: <F198nwpGR881Np7vXee0002516d@hotmail.com>
Message-ID: <Pine.LNX.4.33L.0201171542330.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2002, Yinlei Yu wrote:

> I am working on a project that keep accessing lots of memory
> randomly(say 500MB-1.5GB) and we do have such amount of memory
> installed so there's almost no page faults while running the entire
> program. Since x86 architecutre has a 4M page feature, is it possible
> to make use of these big pages instead of 4K pages in my program (a
> user-level application) so I can expect much fewer TLB misses due to
> the reduced number of TLB entries?

This isn't currently implemented, still somewhere on the TODO list ;/

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

