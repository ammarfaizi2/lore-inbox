Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266345AbRGBC6y>; Sun, 1 Jul 2001 22:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266348AbRGBC6o>; Sun, 1 Jul 2001 22:58:44 -0400
Received: from 513.holly-springs.nc.us ([216.27.31.173]:34374 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S266345AbRGBC6i>; Sun, 1 Jul 2001 22:58:38 -0400
Subject: Re: Soft updates for 2.5?
From: Michael Rothwell <rothwell@holly-springs.nc.us>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Alex Khripin <akhripin@morgoth.mit.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0107012331360.19985-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0107012331360.19985-100000@imladris.rielhome.conectiva>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10.99 (Preview Release)
Date: 01 Jul 2001 22:58:04 -0400
Message-Id: <994042685.12022.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While on the topic of reslilent, high-performance filesystems, what ever
became of "Tux", Daniel Philip's mythical WAFL-type filesystem?

On 01 Jul 2001 23:33:52 -0300, Rik van Riel wrote:
> On Sat, 30 Jun 2001, Alex Khripin wrote:
> 
> > There was a discussion in October, 2000, about the Granger and
> > McKusick paper on soft updates for the BSD FFS. Reading the thread,
> > nothing conclusive seemed to come out of it.
> 
> What you want is ext3.
> 
> It is a journaling version of ext2, which basically
> means you get all the advantages of soft updates and
> a bit more (due to the atomicity that journaled
> transactions can give you).
> 
> It should be superior to softupdates in both the
> consistency area and the performance area (due to
> the fact that stuff is in the journal, you have
> more freedom to reorder the writes to the "main"
> part of the filesystem).
> 
> regards,
> 
> Rik
> --
> Virtual memory is like a game you can't win;
> However, without VM there's truly nothing to lose...
> 
> http://www.surriel.com/		http://distro.conectiva.com/
> 
> Send all your spam to aardvark@nl.linux.org (spam digging piggy)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--
Michael Rothwell
rothwell@holly-springs.nc.us


