Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269027AbRG3R0H>; Mon, 30 Jul 2001 13:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269029AbRG3RZ5>; Mon, 30 Jul 2001 13:25:57 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:25093 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269028AbRG3RZw>; Mon, 30 Jul 2001 13:25:52 -0400
Date: Mon, 30 Jul 2001 14:25:51 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Lawrence Greenfield <leg+@andrew.cmu.edu>
Cc: "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>,
        <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Chris Wedgwood <cw@f00f.org>, Chris Mason <mason@suse.com>
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <200107301711.f6UHBWHE001945@acap-dev.nas.cmu.edu>
Message-ID: <Pine.LNX.4.33L.0107301422120.5582-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 30 Jul 2001, Lawrence Greenfield wrote:
>    From: "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>
>    Date: 	30 Jul 2001 12:46:13 -0400
>
>    > Besides BSD softupdates and the various journaling
>    > filesystems which are in use on other Unixen also
>    > don't provide the 4.3BSD solution any more ...
>
>    This surprises me if it is true; do you have a reference?  And what
>    mechanism *do* the modern BSDs provide to commit metadata changes to
>    disk?
>
> BSD softupdates allows you to call fsync() on the file, and this will
> sync the directories all the way up to the root if necessary.
>
> Thus BSD fsync() actually guarantees that when it returns, the file
> (and all of it's filenames) will survive a reboot.

Note that this is very different from the "link() should be
synchronous()" mantra we've been hearing over the last days.

These fsync() semantics make lots of sense to me, I'm all
for it.

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

