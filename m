Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264433AbRGISLU>; Mon, 9 Jul 2001 14:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264447AbRGISLA>; Mon, 9 Jul 2001 14:11:00 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:19215 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S264433AbRGISKu>;
	Mon, 9 Jul 2001 14:10:50 -0400
Date: Mon, 9 Jul 2001 15:10:31 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: "Ernest N. Mamikonyan" <ernest@newton.physics.drexel.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: increasing the TASK_SIZE
In-Reply-To: <3B44DA51.10D3F0C0@newton.physics.drexel.edu>
Message-ID: <Pine.LNX.4.33L.0107091509230.9081-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jul 2001, Ernest N. Mamikonyan wrote:

> I was wondering how I can increase the process address space, TASK_SIZE
> (PAGE_OFFSET), in the current kernel. It looks like the 3 GB value is
> hardcoded in a couple of places and is thus not trivial to alter. Is
> there any good reason to limit this value at all, why not just have it
> be the same as the max addressable space (64 GB)? We have an ix86 SMP
> box with 4 GB of RAM and want to be able to allocate all of it to a
> single program (physics simulation). I would greatly appreciate any help
> on this.

The only way to achieve your goal would be to modify the
hardware. What you want is not possible due to hardware
limitations of the x86 platform.

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

