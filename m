Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267961AbRGZNzn>; Thu, 26 Jul 2001 09:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267968AbRGZNze>; Thu, 26 Jul 2001 09:55:34 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:45320 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S267961AbRGZNzW>; Thu, 26 Jul 2001 09:55:22 -0400
Date: Thu, 26 Jul 2001 10:55:20 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <E15PlYr-0003mr-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33L.0107261054070.20326-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, 26 Jul 2001, Alan Cox wrote:

> > The competition is there and it has names: BSD + ufs + softupdates,
> > Solaris + logging ufs. Read MTA mailing lists before obstructing.
>
> All of which are - not unsuprisingly - using a log. In fact
> Solaris logging ufs and ext3 are very similar ideas - adding a
> log to an existing fs.

Softupdates isn't using logging.  Furthermore, even
the journaling filesystems won't all guarantee that
the various parts of a rename() operation will all
be in the same transaction.

An MTA which relies on this is therefore Broken(tm).

cheers,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

