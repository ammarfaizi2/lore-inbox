Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268871AbRHBJ5G>; Thu, 2 Aug 2001 05:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268872AbRHBJ44>; Thu, 2 Aug 2001 05:56:56 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:57358 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S268871AbRHBJ4m>; Thu, 2 Aug 2001 05:56:42 -0400
Date: Thu, 2 Aug 2001 06:56:47 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Christoph Hellwig <hch@ns.caldera.de>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        <linux-kernel@vger.kernel.org>, <sct@redhat.com>
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <200108020951.f729pAc13598@ns.caldera.de>
Message-ID: <Pine.LNX.4.33L.0108020655530.5582-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2001, Christoph Hellwig wrote:

> > Well, if there's not a single dirent, you cannot retrieve the data,
>
> Of course you can, you can pass and fd for an unliked file
> everywhere using AF_LOCAL descriptor passing.

But this assumes the system doesn't crash, while
fsync() seems meant more as a protection against
the system going down unexpectedly ...

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

