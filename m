Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318030AbSGLWML>; Fri, 12 Jul 2002 18:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318031AbSGLWMK>; Fri, 12 Jul 2002 18:12:10 -0400
Received: from ns.suse.de ([213.95.15.193]:13834 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318030AbSGLWMI>;
	Fri, 12 Jul 2002 18:12:08 -0400
Date: Sat, 13 Jul 2002 00:14:56 +0200
From: Dave Jones <davej@suse.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thunder from the hill <thunder@ngforever.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] 56 potential lock/unlock bugs in 2.5.8
Message-ID: <20020713001456.H18503@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Roman Zippel <zippel@linux-m68k.org>,
	Thunder from the hill <thunder@ngforever.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20020712233849.G18503@suse.de> <Pine.LNX.4.44.0207122348090.28515-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0207122348090.28515-100000@serv>; from zippel@linux-m68k.org on Fri, Jul 12, 2002 at 11:56:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2002 at 11:56:07PM +0200, Roman Zippel wrote:

 > > if 2.4/2.5 AFFS is in sync as you say (which iirc it is), then
 > > I fail to see how you think the 2.5.25 disassembly is an old version.
 > The last disassembled instruction is the PageUptodate() test, which was
 > moved in later versions and can't be that early in the function for a
 > recent version, but the disassembly is exactly what I would expect from
 > an old affs version.

Hmm, interesting. Time to test the possibility of a ccache bug I think.
How old exactly out of curiosity ?

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
