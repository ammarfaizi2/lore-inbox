Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268453AbRGXUck>; Tue, 24 Jul 2001 16:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268452AbRGXUcb>; Tue, 24 Jul 2001 16:32:31 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:49937 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S268449AbRGXUcY>; Tue, 24 Jul 2001 16:32:24 -0400
Date: Tue, 24 Jul 2001 17:32:26 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Patrick Dreker <patrick@dreker.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, <phillips@bonn-fries.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Optimization for use-once pages
In-Reply-To: <E15P8jB-0000Au-00@wintermute>
Message-ID: <Pine.LNX.4.33L.0107241731400.20326-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, 24 Jul 2001, Patrick Dreker wrote:

	[snip program with mmap()]

> I have tested this on my Athlon 600 with 128 Megs of RAM, and it
> does not make any difference whether I use plain 2.4.7 or
> 2.4.5-use-once.

As expected. Only programs using generic_file_{read,write}()
will be impacted at the moment.

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

