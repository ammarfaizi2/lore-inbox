Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265128AbRGJBl4>; Mon, 9 Jul 2001 21:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265334AbRGJBlq>; Mon, 9 Jul 2001 21:41:46 -0400
Received: from dnscache.cbr.au.asiaonline.net ([210.215.8.100]:63636 "EHLO
	dnscache.cbr.au.asiaonline.net") by vger.kernel.org with ESMTP
	id <S265128AbRGJBle>; Mon, 9 Jul 2001 21:41:34 -0400
Message-ID: <3B4A5D16.45954897@acm.org>
Date: Tue, 10 Jul 2001 11:40:38 +1000
From: Gareth Hughes <gareth.hughes@acm.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: "Ernest N. Mamikonyan" <ernest@newton.physics.drexel.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: increasing the TASK_SIZE
In-Reply-To: <Pine.LNX.4.33L.0107091509230.9081-100000@imladris.rielhome.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Thu, 5 Jul 2001, Ernest N. Mamikonyan wrote:
> 
> > I was wondering how I can increase the process address space, TASK_SIZE
> > (PAGE_OFFSET), in the current kernel. It looks like the 3 GB value is
> > hardcoded in a couple of places and is thus not trivial to alter. Is
> > there any good reason to limit this value at all, why not just have it
> > be the same as the max addressable space (64 GB)? We have an ix86 SMP
> > box with 4 GB of RAM and want to be able to allocate all of it to a
> > single program (physics simulation). I would greatly appreciate any help
> > on this.
> 
> The only way to achieve your goal would be to modify the
> hardware. What you want is not possible due to hardware
> limitations of the x86 platform.

I had a sneaking suspicion I didn't know what I was talking about. 
Should have read his original email a little closer :-)

-- Gareth
