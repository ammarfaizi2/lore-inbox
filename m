Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266834AbRGFUlr>; Fri, 6 Jul 2001 16:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266838AbRGFUlh>; Fri, 6 Jul 2001 16:41:37 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:28176 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S266834AbRGFUlZ>; Fri, 6 Jul 2001 16:41:25 -0400
Date: Fri, 6 Jul 2001 17:41:16 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Sasha Pachev <sasha@mysql.com>
Cc: Mike Kravetz <mkravetz@sequent.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Strange thread behaviour on 8-way x86 machine
In-Reply-To: <01070614353314.17811@mysql>
Message-ID: <Pine.LNX.4.33L.0107061740560.17825-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2001, Sasha Pachev wrote:
> On Friday 06 July 2001 13:24, Rik van Riel wrote:
> > On Fri, 6 Jul 2001, Sasha Pachev wrote:
> >
> > > Upon further investigation and testing, it turned out that the kernel was
> not
> > > at fault - the problem was high mutex contention, which caused frequent
> > > context switches, and the idle CPU was apparently from the scheduler
> waiting
> > > for the original CPU to become available too often.
> > >
> > > On a side note, it would be nice if a process could communicate
> > > to the kernel that it would rather run on the first available
> > > CPU than wait for the perfect one to become available.
> >
> > The kernel already does this.
>
> Thanks for the info. Would you mind proving a one line pointer
> on how to tell this to the kernel?

It always does this, by default.  AFAIK you cannot turn it off.

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

