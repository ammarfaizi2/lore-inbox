Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265771AbRGBCe2>; Sun, 1 Jul 2001 22:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265361AbRGBCeS>; Sun, 1 Jul 2001 22:34:18 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:48402 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S265351AbRGBCeG>;
	Sun, 1 Jul 2001 22:34:06 -0400
Date: Sun, 1 Jul 2001 23:33:52 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Alex Khripin <akhripin@morgoth.mit.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Soft updates for 2.5?
In-Reply-To: <200106301041.f5UAfCVM012803@morgoth.mit.edu>
Message-ID: <Pine.LNX.4.33L.0107012331360.19985-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jun 2001, Alex Khripin wrote:

> There was a discussion in October, 2000, about the Granger and
> McKusick paper on soft updates for the BSD FFS. Reading the thread,
> nothing conclusive seemed to come out of it.

What you want is ext3.

It is a journaling version of ext2, which basically
means you get all the advantages of soft updates and
a bit more (due to the atomicity that journaled
transactions can give you).

It should be superior to softupdates in both the
consistency area and the performance area (due to
the fact that stuff is in the journal, you have
more freedom to reorder the writes to the "main"
part of the filesystem).

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

