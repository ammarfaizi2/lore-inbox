Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274337AbRJNFmS>; Sun, 14 Oct 2001 01:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274362AbRJNFmJ>; Sun, 14 Oct 2001 01:42:09 -0400
Received: from www.wen-online.de ([212.223.88.39]:13829 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S274337AbRJNFmC>;
	Sun, 14 Oct 2001 01:42:02 -0400
Date: Sun, 14 Oct 2001 07:41:20 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: <rwhron@earthlink.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
        <ltp-list@lists.sourceforge.net>
Subject: Re: VM test on 2.4.12-ac1, 2.4.12aa1, and 2.4.13-pre2
In-Reply-To: <20011014010333.A245@earthlink.net>
Message-ID: <Pine.LNX.4.33.0110140729280.361-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Oct 2001 rwhron@earthlink.net wrote:

> Kernels test summary:
>
> 2.4.12-ac1	Wide variance in memory allocation
> 2.4.12aa1	Interesting vmstat/mp3blaster pattern
> 2.4.13-pre2	Locked up on 7th iteration
>
> Test:
>
> Run loop of 10 iterations of Linux Test Project's "mtest01 -p80 -w"
> This test attempts to allocate 80% of virtual memory and write to
> each page.  Simulataneously listen to mp3blaster.

Hi,

You should try out 2.4.13pre2.aa1.. it out performs both 2.4.12-ac1 and
2.4.13-pre2 with the [heavy] vm burner I watch here.  It's considerably
smoother than 2.4.13-pre2 at full throttle, with improved cpu utilization.

	-Mike

