Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269118AbRGaAeI>; Mon, 30 Jul 2001 20:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269123AbRGaAd6>; Mon, 30 Jul 2001 20:33:58 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:56082 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269118AbRGaAdl>; Mon, 30 Jul 2001 20:33:41 -0400
Date: Mon, 30 Jul 2001 21:33:46 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <20010731022834.F28253@emma1.emma.line.org>
Message-ID: <Pine.LNX.4.33L.0107302132030.5582-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, 31 Jul 2001, Matthias Andree wrote:
> On Mon, 30 Jul 2001, Rik van Riel wrote:
>
> > Hmmm, then maybe we'd just want some flag to fsync()
> > telling the kernel to also sync the parent directory
> > of the file and do whatever it needs to do to get the
> > rename() or link() committed ?
>
> Heck, you can't tell the kernel to do rename/link/open/unlink
> synchronously in-band. This list doesn't care for other OS's.
> The semantics FreeBSD (e. g.) offers ARE indeed documented.

Go back a few posts and read about the semantics
FreeBSD has when the filesystem is mounted with
softupdates.

Then take a deep breath.

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

