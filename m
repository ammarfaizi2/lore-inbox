Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262255AbSJARKj>; Tue, 1 Oct 2002 13:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262252AbSJARK3>; Tue, 1 Oct 2002 13:10:29 -0400
Received: from dsl-213-023-043-077.arcor-ip.net ([213.23.43.77]:23708 "EHLO
	starship") by vger.kernel.org with ESMTP id <S262239AbSJARIw>;
	Tue, 1 Oct 2002 13:08:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: 2.4 mm trouble [possible lru race]
Date: Tue, 1 Oct 2002 19:10:20 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Richard.Zidlicky@stud.informatik.uni-erlangen.de, <zippel@linux-m68k.org>,
       <linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L.0210011356300.653-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.44L.0210011356300.653-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17wQXN-0005vL-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 October 2002 18:56, Rik van Riel wrote:
> On Tue, 1 Oct 2002, Daniel Phillips wrote:
> > On Tuesday 01 October 2002 16:20, Richard.Zidlicky@stud.informatik.uni-erlangen.de wrote:
> 
> > > no preempt or anything fancy, m68k vanila 2.4.19 (well almost).
> >
> > Vanilla would be CONFIG_SMP=y, is that what you have?
> 
> Somehow I doubt Linux supports m68k SMP machines ;)

CONFIG_SMP=y works perfectly well on single cpu machines - it forces
the spinlocks to actually exist.  It's not supposed to change any
behaviour, but you never know.  Behaviour is obviously changing here.

-- 
Daniel
