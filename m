Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268933AbRG0TSU>; Fri, 27 Jul 2001 15:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268931AbRG0TSJ>; Fri, 27 Jul 2001 15:18:09 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:11013 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S268928AbRG0TR6>; Fri, 27 Jul 2001 15:17:58 -0400
Date: Fri, 27 Jul 2001 16:17:56 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Samuel Dupas <samuel@dupas.com>
Cc: Jeremy Linton <jlinton@interactivesi.com>, <linux-kernel@vger.kernel.org>
Subject: Re: swap_free: swap-space map bad (entry 00000100)
In-Reply-To: <20010727183745.4b36b358.samuel@dupas.com>
Message-ID: <Pine.LNX.4.33L.0107271616170.5582-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, 27 Jul 2001, Samuel Dupas wrote:
> On Fri, 27 Jul 2001 12:29:18 -0500
> "Jeremy Linton" <jlinton@interactivesi.com> wrote:
> > Did you do a 'swapoff' at some point before this?
> >
>
> No, I didn't change anything. I just put stress on it with ab to
> test the machine but it felt down :-((
>
> Others ideas ?

The memory corruption you saw usually (almost always)
indicates a hardware problem. It may not have shown up
during normal usage because without ab your RAM has
more idle time and can keep up refreshing itself
easily.

Flakey mainboard chipsets could "forget" about such
things under heavy DMA load, or ...   (who knows)

Setting the BIOS settings one notch more conservative
often fixes these marginal errors.

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

