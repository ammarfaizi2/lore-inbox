Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268500AbRGXW1g>; Tue, 24 Jul 2001 18:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268496AbRGXW10>; Tue, 24 Jul 2001 18:27:26 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:37649 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S266069AbRGXW1T>; Tue, 24 Jul 2001 18:27:19 -0400
Date: Tue, 24 Jul 2001 19:27:18 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Daniel Phillips <phillips@bonn-fries.net>, <linux-kernel@vger.kernel.org>,
        Ben LaHaise <bcrl@redhat.com>, Mike Galbraith <mikeg@wen-online.de>
Subject: Re: [RFC] Optimization for use-once pages
In-Reply-To: <Pine.LNX.4.21.0107241750090.2263-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33L.0107241925550.20326-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, 24 Jul 2001, Marcelo Tosatti wrote:

> Daniel's patch adds "drop behind" (that is, adding swapcache
> pages to the inactive dirty) behaviour to swapcache pages.
>
> This is a _new_ thing, and I would like to know how that is
> changing the whole VM behaviour..

It means that swap cache pages get about 1 second
to be used (in theory, under load) and after that
they can get evicted.

Should show up nicely with your VM stats patch...

Lets try to get the VM statistics patch merged,
after that we can talk about this stuff without
having to use our phantasy as much as we use it
now ;))

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

