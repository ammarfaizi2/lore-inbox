Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261507AbSJPVyp>; Wed, 16 Oct 2002 17:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261508AbSJPVyp>; Wed, 16 Oct 2002 17:54:45 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:61372 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261507AbSJPVyo>; Wed, 16 Oct 2002 17:54:44 -0400
Date: Wed, 16 Oct 2002 19:23:10 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: David Coulson <david@davidcoulson.net>
Cc: linux-kernel@vger.kernel.org,
       UML devel <user-mode-linux-devel@lists.sourceforge.net>
Subject: Re: swap_dup/swap_free errors with 2.4.20-pre10
In-Reply-To: <3DAC0063.9080701@davidcoulson.net>
Message-ID: <Pine.LNX.4.44L.0210161922570.5583-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 Oct 2002, David Coulson wrote:

> I'm running 2.4.20-pre10 on a Dual PIII system with 2Gb of RAM and three
> 2Gb swap logical volumes.
>
> It runs fine for a while, then I get lots of;
>
> Oct 15 12:41:31 maeve kernel: swap_dup: Bad swap file entry 00000020
> Oct 15 12:41:31 maeve kernel: swap_dup: Bad swap file entry 00000020
> Oct 15 12:41:31 maeve kernel: swap_free: Bad swap file entry 00000020
> Oct 15 12:41:31 maeve kernel: swap_free: Bad swap file entry 00000020
> Oct 15 12:41:31 maeve kernel: swap_dup: Bad swap file entry 00000020
> Oct 15 12:41:31 maeve kernel: swap_dup: Bad swap file entry 00000020
> Oct 15 12:41:31 maeve kernel: swap_free: Bad swap file entry 00000020
>
> The address is always 00000020. I've tried the machine without any swap
> space, and I get exactly the same error, so I'm assuming it's either bad
> RAM or a kernel issue. I ran memtest86 on it yesterday, and it didn't
> throw up any errors, but I'm going to swap the RAM out and see if that
> fixes it.

Any news on this one, David?

