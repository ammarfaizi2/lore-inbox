Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130153AbRCBXxQ>; Fri, 2 Mar 2001 18:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130162AbRCBXxF>; Fri, 2 Mar 2001 18:53:05 -0500
Received: from h170n1fls20o70.telia.com ([213.64.50.170]:40579 "EHLO
	garbo.localnet") by vger.kernel.org with ESMTP id <S130153AbRCBXwt>;
	Fri, 2 Mar 2001 18:52:49 -0500
Message-ID: <3AA0323A.2ED09AB@canit.se>
Date: Sat, 03 Mar 2001 00:52:26 +0100
From: Kenneth Johansson <ken@canit.se>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matt_Domsch@Dell.com
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4 and 2GB swap partition limit
In-Reply-To: <CDF99E351003D311A8B0009027457F1403BF9DFB@ausxmrr501.us.dell.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt_Domsch@Dell.com wrote:

> Linus has spoken, and 2.4.x now requires swap = 2x RAM.
> But, the 2GB per swap partition limit still exists, best as we can tell.
> So, we sell machines with say 8GB RAM.  We need 16GB swap, but really we
> need like an 18GB disk with 8 2GB swap partitions, or ideally 8 disks with a
> 2GB swap partition on each.  That's ugly.
>
> Is the 2GB per swap partition going to go away any time soon?
>
> Thanks,
> Matt
>

I know Rik have some plans but I don't know the time table.

On the other hand do you really need swap partitions how about using swap
files? That way you don't need to manage alot of partitons and you can test if
you really do need to go all the way to 2xRAM. It dose look a bit silly to have

16GB swap. Are you really going to load the machine with work that needs more
than 8GB?? if not you don't really need any swap.

I have not created any swap partitons in years and mostly run without any swap
whatsoever. It's easy to create one temporary if I know I'am going to use more
memory than I have. Obviously on a server it's better to be safe than sorry.



