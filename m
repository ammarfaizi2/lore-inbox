Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265754AbRGXSPW>; Tue, 24 Jul 2001 14:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268419AbRGXSPM>; Tue, 24 Jul 2001 14:15:12 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:59654 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S265754AbRGXSPC>; Tue, 24 Jul 2001 14:15:02 -0400
Date: Tue, 24 Jul 2001 15:15:01 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Optimization for use-once pages
In-Reply-To: <01072420143600.00520@starship>
Message-ID: <Pine.LNX.4.33L.0107241514160.20326-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, 24 Jul 2001, Daniel Phillips wrote:
> On Tuesday 24 July 2001 19:04, Rik van Riel wrote:

> Memory-mapped files have to be handled too.

> > In order to prevent this from happening, either the system
> > counts all first references in a short timespan (complex to
> > implement) or it has the new pages on a special - small fixed
> > size - page list and all references to the page while on that
> > list are ignored.
>
> Yes, those are both possibilities.

The special "new pages" list handles the mmap() situation
automatically.

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

