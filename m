Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269183AbRHBW1w>; Thu, 2 Aug 2001 18:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269193AbRHBW1m>; Thu, 2 Aug 2001 18:27:42 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:25607 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269183AbRHBW1g>; Thu, 2 Aug 2001 18:27:36 -0400
Date: Thu, 2 Aug 2001 19:27:42 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: "Jeffrey W. Baker" <jwbaker@acm.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Ongoing 2.4 VM suckage
In-Reply-To: <Pine.LNX.4.33.0108021508310.21298-100000@heat.gghcwest.com>
Message-ID: <Pine.LNX.4.33L.0108021925460.5582-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2001, Jeffrey W. Baker wrote:

> I'm telling you that's not what happens.  When memory pressure
> gets really high, the kernel takes all the CPU time and the box
> is completely useless. Maybe the VM sorts itself out but after
> five minutes of barely responding, I usually just power cycle
> the damn thing.  As I said, this isn't a classic thrash because
> the swap disks only blip perhaps once every ten seconds!

What kind of workload are you running ?

We could be dealing with some weird artifact of
virtual page scanning here, or with a strange
side effect of recent VM changes ...

> I'm very familiar with what should happen on a Unix box when
> user processes get huge.  On my FreeBSD and Solaris machines,
> everything goes to shit for a few minutes and then it comes
> back.  Linux used to work that way too, but I can't count on the
> comeback in 2.4.

I'm trying to make the machine behave again, but
VM balancing isn't the easiest thing there is.
Especially not while other people's experiments
get applied to the kernel tree ;(

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

