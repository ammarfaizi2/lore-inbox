Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312334AbSDJHdj>; Wed, 10 Apr 2002 03:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312344AbSDJHdi>; Wed, 10 Apr 2002 03:33:38 -0400
Received: from mgw-x2.nokia.com ([131.228.20.22]:9648 "EHLO mgw-x2.nokia.com")
	by vger.kernel.org with ESMTP id <S312334AbSDJHdi>;
	Wed, 10 Apr 2002 03:33:38 -0400
Date: Wed, 10 Apr 2002 10:33:31 +0300 (EEST)
From: Matilainen Panu <panu.matilainen@nokia.com>
X-X-Sender: pmatilai@es-adsl-soho-30-186.europe.nokia.com
To: "ext  =?iso-8859-1?Q?Rune_F._V=E6rnes?=" <rune@nailflare.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at slab.c:1099!
In-Reply-To: <001e01c1e003$2dd7ddd0$3201000a@rom5>
Message-ID: <Pine.LNX.4.44.0204101025210.10379-100000@es-adsl-soho-30-186.europe.nokia.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 10 Apr 2002 07:33:35.0791 (UTC) FILETIME=[0629E3F0:01C1E062]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2002, ext  Rune F. Værnes wrote:

> 1.] One line summary of the problem:
> setting up a nokia_c110 pcmcia card. Problem with slab.h/malloc.h
> 
> [2.] Full description of the problem/report:
> Compiled code for the nokia card and loaded the module(nokia_c110)
> The code uses malloc.h... tried to ues slab.h but no  help.
> When cardmgr starts up the kernel reports a kernel BUG.
> 
> 
> [3.] Keywords (i.e., modules, networking, kernel):
> module kernel
> 
> [4.] Kernel version (from /proc/version):
> 2.4.18-6mdk

I'm afraid nobody at linux-kernel can help you here as the nokia_c110
driver consists of a large binary-only module which "taints" the kernel
makes it undebuggable. The documentation says the driver has only been
tested up to (unpatched)  2.4.12 kernel .. your best chance is to 
a) Make sure you have the latest version of the driver & firmware
   (some earlier version was known to be broken with 2.4.6 or so upwards) 
b) Contact Nokia product support and hope they'll fix this in a future 
   release.

P.S. Sorry but even though I come from @nokia.com address I can't help you 
with this as I don't have (and wouldn't be able to get to) the source to 
the binary part either :(

	- Panu -


