Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318047AbSGRMzP>; Thu, 18 Jul 2002 08:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318051AbSGRMzO>; Thu, 18 Jul 2002 08:55:14 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:457 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S318047AbSGRMzN>;
	Thu, 18 Jul 2002 08:55:13 -0400
Date: Thu, 18 Jul 2002 14:58:08 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>, gunther.mayer@gmx.net
Subject: Re: PS2 Input Core Support
Message-ID: <20020718145808.F29630@ucw.cz>
References: <B3D59960FB3@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <B3D59960FB3@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Thu, Jul 18, 2002 at 12:17:51PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 12:17:51PM +0200, Petr Vandrovec wrote:

> > Cool! Anyone send me a patch? ;)
> 
> Been there, done that... and unfortunately, my WOP35 insist on
> taking first 6 bytes as PS/2->ImPS/2 sequence, and rest as normal
> DPI settings. I tried it in reverse order, and couple of permutations,
> but it still returns ExPS/2 id. I tried also other sequences from
> gm_psauxprint-0.01, but I found nothing interesting, except that
> mouse definitely does not support MS PNP id.
> 
> Answer from A4Tech support was that mouse is not supported under Linux,
> and that I should use Windows and verify that mouse is properly connected.
> So I'm on the best way to the command line switch, I think. Google
> find couple of problem reporters, but nobody found detection method :-(

Well, it should be possible to snoop the mouse data off the wire using
a slightly modified parkbd.c module on a different machine and a split
PS/2 mouse cable ...

-- 
Vojtech Pavlik
SuSE Labs
