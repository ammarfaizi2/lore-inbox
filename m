Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131691AbRA3SLF>; Tue, 30 Jan 2001 13:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131799AbRA3SK4>; Tue, 30 Jan 2001 13:10:56 -0500
Received: from adsl-209-182-168-213.value.net ([209.182.168.213]:24329 "EHLO
	draco.foogod.com") by vger.kernel.org with ESMTP id <S131691AbRA3SKn>;
	Tue, 30 Jan 2001 13:10:43 -0500
Date: Tue, 30 Jan 2001 10:10:09 -0800
From: alex@foogod.com
To: Rik van Riel <riel@conectiva.com.br>
Cc: alex@foogod.com, Alan Olsen <alan@clueserver.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Recommended swap for 2.4.x.
Message-ID: <20010130101009.B13819@draco.foogod.com>
In-Reply-To: <20010129152335.H11411@draco.foogod.com> <Pine.LNX.4.21.0101300945500.1321-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Pine.LNX.4.21.0101300945500.1321-100000@duckman.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2001 at 09:48:33AM -0200, Rik van Riel wrote:
> It has. We now leave dirty pages swapcached, which means that
> for certain workloads Linux 2.4 eats up much more swap space
> than Linux 2.2.

Ah.. thanks for the clarification.  Is this duplication "hard" or "soft"?  
i.e. under low-memory conditions, do these duplicated pages actually reduce 
the hard limit of VM available, or just imply that using that last bit of 
memory will entail greater paging overhead (because it has to do more cleanup)?

Does this mean that having a swap partition less than or equal to RAM is now 
effectively pointless?

-alex
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
