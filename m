Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315427AbSFENx5>; Wed, 5 Jun 2002 09:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315430AbSFENx4>; Wed, 5 Jun 2002 09:53:56 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:8457 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S315427AbSFENxz>;
	Wed, 5 Jun 2002 09:53:55 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, release 3.0 is available 
In-Reply-To: Your message of "Tue, 04 Jun 2002 14:53:28 +1000."
             <11725.1023166408@kao2.melbourne.sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 05 Jun 2002 23:53:43 +1000
Message-ID: <26430.1023285223@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jun 2002 12:35:05 +1000, 
Keith Owens <kaos@ocs.com.au> wrote:
>Release 3.0 of kernel build for kernel 2.5 (kbuild 2.5) is available.
>http://sourceforge.net/projects/kbuild/, package kbuild-2.5, download
>release 3.0.

New files:

kbuild-2.5-core-17
kbuild-2.5-common-2.5.20-3
kbuild-2.5-i386-2.5.20-2

    Synchronize link order with 2.5.20.  Between 2.5.15 and 2.5.19
    there were several changes to the kernel link order that look
    dubious to me.  Originally kbuild 2.5 for 2.5.20 preserved the
    original order from 2.5.15, but I have since decided to follow the
    2.5.20 link order, even if it looks broken in places.

    common-2.5.20-3 also adds workarounds for include/linux/zlib.h.

