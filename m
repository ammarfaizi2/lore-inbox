Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288248AbSBMSZo>; Wed, 13 Feb 2002 13:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288262AbSBMSZe>; Wed, 13 Feb 2002 13:25:34 -0500
Received: from chaos.analogic.com ([204.178.40.224]:40069 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S288248AbSBMSZQ>; Wed, 13 Feb 2002 13:25:16 -0500
Date: Wed, 13 Feb 2002 13:27:54 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ? 
In-Reply-To: <Pine.LNX.4.33L2.0202130857320.1530-200000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.3.95.1020213132419.20719A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2002, Randy.Dunlap wrote:

> On Wed, 13 Feb 2002, Richard B. Johnson wrote:
> 
> | On Wed, 13 Feb 2002, Horst von Brand wrote:
> |
> | > Daniel Phillips <phillips@bonn-fries.net> said:
> | > > On February 12, 2002 05:38 pm, Bill Davidsen wrote:
> | >
> | > [...]
> | [SNIPPED...]
> |
> | My idea is to take the .config file and remove most of its
> | redundancy and unnecessary verbage. Then, the result is
> | compressed and written to a constant global array, linked
> | into the kernel. Both the array and the array length will then
> | be available from /proc/kcore for user-mode tools to recreate the
> | .config file.
> 
> This is a bit similar to what I did last weekend (and attach
> here).  Mine goes into the kernel boot file, however, so that
> it can be read even when the kernel isn't running.
> 
> I'll experiment with ideas from Andreas (thanks) or Ian Soboroff
> to create a userspace get-config tool.
> 
> One small nit:  you say "user-mode tools", but /proc/kcore
> is read-only for root only -- right?
> That's not desirable or required IMO.
> 

Hmmm. You are going to make a kernel and don't have root-access to
create a kernel configuration file?

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


