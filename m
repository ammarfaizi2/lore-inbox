Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262455AbRENUBw>; Mon, 14 May 2001 16:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262463AbRENUBm>; Mon, 14 May 2001 16:01:42 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:28688 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S262455AbRENUBZ>; Mon, 14 May 2001 16:01:25 -0400
Date: Mon, 14 May 2001 17:01:13 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Jeff Golds <jgolds@resilience.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4 kernel reports wrong amount of physical memory
In-Reply-To: <3B002D61.191C03C@resilience.com>
Message-ID: <Pine.LNX.4.33.0105141659570.18102-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 May 2001, Jeff Golds wrote:

> I installed the 2.4.4 kernel on a dual P3-733 system with 1 GB
> of ECC RAM and found that /proc/meminfo reports back only 899MB
> of RAM.

> Anyone know what is going on with 2.4.4?

-EUSER  (User Error)

You need to compile highmem support into the kernel if you
want to use more than 890 MB of RAM, set it to maximum 4GB
for best performance...

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

