Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278625AbRJSTh7>; Fri, 19 Oct 2001 15:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278626AbRJSTht>; Fri, 19 Oct 2001 15:37:49 -0400
Received: from barrichello.cs.ucr.edu ([138.23.169.5]:34767 "HELO
	barrichello.cs.ucr.edu") by vger.kernel.org with SMTP
	id <S278625AbRJSThm>; Fri, 19 Oct 2001 15:37:42 -0400
Date: Fri, 19 Oct 2001 12:04:41 -0700 (PDT)
From: John Tyner <jtyner@cs.ucr.edu>
To: Timur Tabi <ttabi@interactivesi.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Newbies Mailing List <kernelnewbies@nl.linux.org>
Subject: Re: Allocating more than 890MB in the kernel?
In-Reply-To: <3BD07586.3090706@interactivesi.com>
Message-ID: <Pine.LNX.4.30.0110191204210.21846-100000@hill.cs.ucr.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS perl-6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Isn't this solved by just recompiling the kernel with HIGHMEM support?

John

On Fri, 19 Oct 2001, Timur Tabi wrote:

> vmalloc() fails after about 890MB because the kernel memory map is only for
> about 1GB.  I know there are some hacks and work-arounds to get more than
> that, but instead of reinventing the wheel, I was hoping some kind soul would
> tell me how (a few hints would be nice!)
>
> The reason we use vmalloc() is because we need to apply memory pressure during
> the allocating: memory should be swapped out to make room for our allocation.
>
> We're trying to allocate up to 3GB on a 4GB machine.  Thanks in advance!
>
> -
> Kernelnewbies: Help each other learn about the Linux kernel.
> Archive:       http://mail.nl.linux.org/kernelnewbies/
> IRC Channel:   irc.openprojects.net / #kernelnewbies
> Web Page:      http://www.kernelnewbies.org/
>

-- 
John Tyner
jtyner@cs.ucr.edu

