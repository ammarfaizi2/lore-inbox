Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267912AbRGZM7b>; Thu, 26 Jul 2001 08:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267918AbRGZM7L>; Thu, 26 Jul 2001 08:59:11 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:2320 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S267912AbRGZM7G>; Thu, 26 Jul 2001 08:59:06 -0400
Date: Thu, 26 Jul 2001 09:58:58 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <20010726143002.E17244@emma1.emma.line.org>
Message-ID: <Pine.LNX.4.33L.0107260956520.20326-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, 26 Jul 2001, Matthias Andree wrote:

> So, what would help the common MTA?

Not relying on non-supported semantics to save your ass.

Rename() is atomic in the sense that you either see the
old name or the new name, but I don't know of systems
which guarantee atomicity across a system crash.

In fact, knowing how hard disks work mechanically, only
journaling filesystems could have an extention to make
this work.  Ie. this is NOT something you can rely on ;)

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

