Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263894AbRFSGNi>; Tue, 19 Jun 2001 02:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263895AbRFSGN2>; Tue, 19 Jun 2001 02:13:28 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:47880 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S263894AbRFSGNQ>; Tue, 19 Jun 2001 02:13:16 -0400
Date: Tue, 19 Jun 2001 03:13:05 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: root <root@norma.kjist.ac.kr>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 VM & swap question
In-Reply-To: <Pine.LNX.4.33.0106190725040.576-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.33.0106190312210.1376-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2001, Mike Galbraith wrote:
> On Mon, 18 Jun 2001, root wrote:
>
> > Regarding to the discussion on the swap size,
> >
> > Recently, Rick van Riel posted a message that there is a bug
> > related to "reclaiming" the swap, and said that it is on his
> > TODO list.
>
> That's fixed.

It's not. We don't reclaim swap space when we run low on
free swap space (by freeing up the space in swap of stuff
which is in RAM).

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

