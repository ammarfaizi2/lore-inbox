Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268596AbRG3WFH>; Mon, 30 Jul 2001 18:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268598AbRG3WE7>; Mon, 30 Jul 2001 18:04:59 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:52487 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S268596AbRG3WEt>; Mon, 30 Jul 2001 18:04:49 -0400
Date: Mon, 30 Jul 2001 19:04:54 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Hans Reiser <reiser@namesys.com>
Cc: Christoph Hellwig <hch@caldera.de>, <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <3B65CFC5.A6B4FC08@namesys.com>
Message-ID: <Pine.LNX.4.33L.0107301904060.5582-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, 31 Jul 2001, Hans Reiser wrote:
> Christoph Hellwig wrote:

> > Nope.  It does a reiserfs_panic instead of letting the wrong arguments
> > slipping into lower layers and possibly on disk and thus corrupting data.
> >
> > And in my opinion correct data is much more worth than one crash more or
> > less (especially with a journaling filesystem).
>
> The cost is not a crash, the cost is performance sucks.

If you can chose between sucky performance or a chance
at silent data corruption ... which would you chose ?

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

