Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263427AbTDXTKy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 15:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263436AbTDXTKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 15:10:47 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40210 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263427AbTDXTKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 15:10:43 -0400
Date: Thu, 24 Apr 2003 12:22:55 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Timothy Miller <miller@techsource.com>
cc: Daniel Phillips <phillips@arcor.de>, John Bradford <john@grabjohn.com>,
       Jamie Lokier <jamie@shareable.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flame Linus to a crisp!
In-Reply-To: <3EA83BBA.5060502@techsource.com>
Message-ID: <Pine.LNX.4.44.0304241219550.22144-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Apr 2003, Timothy Miller wrote:
>
> For their smaller devices, Xilinx has a free "WebPack" which is a 
> complete Verilog synthesizer (I don't know if it does VHDL), as well as 
> place & route, of course.  I think it'll do up to Virtex II 250.  It 
> also tends use fewer gates for a given design than the version of 
> Leonardo Spectrum we have.  It just doesn't have a simulator, which is 
> vital to any good development process.  Also, the Web Pack only runs 
> under Windows.  Maybe it'll work with WINE?

It does work with wine - but it's sad how horrible the command line tools
are (they were apparently first done under UNIX, and then ported to 
Windows, and they got the Windows command line interface and trying to use 
them in a sane way with Wine is not exactly much fun).

But yes, with Wine and a few scripts you can actually make the tools 
usable under Linux - I tried them out and had a small silly "pong" game 
running on one of those things (a 100k device on one of the cheap 
development boards).

I have to admit that I would hate to actually use those tools for any real 
work, though. 

			Linus

