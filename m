Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265714AbRFXCyh>; Sat, 23 Jun 2001 22:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265715AbRFXCy1>; Sat, 23 Jun 2001 22:54:27 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:45325 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S265714AbRFXCyJ>; Sat, 23 Jun 2001 22:54:09 -0400
Date: Sat, 23 Jun 2001 23:54:06 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: <tcm@nac.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Possible freezing bug located after ac13
In-Reply-To: <20010623222954.A9031@debian>
Message-ID: <Pine.LNX.4.33L.0106232353100.3161-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jun 2001 tcm@nac.net wrote:

> I've recently been going slightly nuts with the fact ac15, 16, and 17
> all like deadlocking/slowing to a crawl for seconds/minutes on my K6-III
> with 64MB of ram and a swap space of 128MB...
>
> Recently I noticed something VERY odd, I'd been keeping an eye on
> gkrellm while I was doing stupid things to produce the problem (a du
> as root in X of / generally would always make it pop up) ... And swap
> was doing I/O at the time *JUST* before when I'd either deadlock or slow
> down to a crawl, and if it recovered, swap would do more I/O...
>
> So. I tried unmounting all swap, and suddenly everything worked fine,
> although I couldn't exactly do everythign I wanted of course.
>
> I regression tested this, ac 16,15 and even 14 do this. ac 13 does *not*
> - IMHO I think the dead swap patches introduced into 14 may be related
> to the problem.

1) the dead swap cache patch should alleviate the problem,
   if anything

2) does this happen with 2.4.6-pre5 too ?

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

