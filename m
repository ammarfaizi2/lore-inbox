Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316162AbSEOMzB>; Wed, 15 May 2002 08:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316163AbSEOMzA>; Wed, 15 May 2002 08:55:00 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:33808 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S316162AbSEOMy7>; Wed, 15 May 2002 08:54:59 -0400
Date: Wed, 15 May 2002 09:43:27 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Ashok Raj <ashokr2@attbi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Address space limits in IA32 linux
In-Reply-To: <PPENJLMFIMGBGDDHEPBBEEJHDAAA.ashokr2@attbi.com>
Message-ID: <Pine.LNX.4.44L.0205150942340.32261-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2002, Ashok Raj wrote:

> what is the maximum addressible virtual address in a IA32 Linux system (4G?)

3 GB.

> typically since Database requires a larger address space, does linux
> kernel has any config to limit this space for kernel, so that the user
> process has more address to play with?

The kernel cannot transparently work around the limitations of the
hardware, but the database itself can create shared memory segments
which it maps and unmaps as needed.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

