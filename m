Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267148AbSLaEhJ>; Mon, 30 Dec 2002 23:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267149AbSLaEhJ>; Mon, 30 Dec 2002 23:37:09 -0500
Received: from 5-116.ctame701-1.telepar.net.br ([200.193.163.116]:35208 "EHLO
	5-116.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S267148AbSLaEhJ>; Mon, 30 Dec 2002 23:37:09 -0500
Date: Tue, 31 Dec 2002 02:45:21 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Ed Tomlinson <tomlins@cam.org>
cc: David Schwartz <davids@webmaster.com>, "" <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH,RFC] fix o(1) handling of threads
In-Reply-To: <200212302303.50119.tomlins@cam.org>
Message-ID: <Pine.LNX.4.50L.0212310244150.2429-100000@imladris.surriel.com>
References: <20021230230030.AAA103@shell.webmaster.com@whenever>
 <200212302303.50119.tomlins@cam.org>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Dec 2002, Ed Tomlinson wrote:
> On December 30, 2002 06:00 pm, David Schwartz wrote:
> >
> > 	In general, changes that cause the system to become less efficient as load
> > increases are not such a good idea. By reducing timeslices, you increase
> > context-switching overhead. So the busier you are, the less efficient you
> > get. I think it would be wiser to keep the timeslice the same but assign
> > fewer timeslices.
>
> That would be better - I cannot see a way to do it using O(1).

I've been thinking about this problem for a while, but haven't
found a good solution yet.  I've got a long way to go before I
can port the per-user fair scheduling stuff to the O(1) base.

cheers,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
