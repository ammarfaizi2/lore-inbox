Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263027AbTC1PrZ>; Fri, 28 Mar 2003 10:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263030AbTC1PrZ>; Fri, 28 Mar 2003 10:47:25 -0500
Received: from splat.lanl.gov ([128.165.17.254]:38029 "EHLO
	balance.radtt.lanl.gov") by vger.kernel.org with ESMTP
	id <S263027AbTC1PrH>; Fri, 28 Mar 2003 10:47:07 -0500
Date: Fri, 28 Mar 2003 08:57:19 -0700
From: Eric Weigle <ehw@lanl.gov>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 3c59x gives HWaddr FF:FF:...
Message-ID: <20030328155719.GC14040@lanl.gov>
References: <20030328145159.GA4265@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030328145159.GA4265@werewolf.able.es>
X-Eric-Conspiracy: There is no conspiracy
X-Editor: Vim, http://www.vim.org
X-GnuPG-fingerprint: 112E F8CA 12A9 771E DB10  6514 D4B0 D758 59EA 9C4F
X-GnuPG-key: http://public.lanl.gov/ehw/ehw.gpg.key
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have just switched the network card for my internal network from a 8139
> to a 3c905C-TX/TX-M. The 3c59x driver gives the buggy FF:FF:FF:FF:FF:FF
> hardware address for the adapter.  [...]
I've seen this on laptops (but never on desktops) when the PCMCIA card wasn't
seated properly-- the connectors wore out after too many plug/unplug cycles.
Something didn't work and it failed over to broadcast.

> Any suggestion ?
If all else fails, yank the card and reseat it.


-Eric

-- 
------------------------------------------------------------
        Eric H. Weigle -- http://public.lanl.gov/ehw/
"They that can give up essential liberty to obtain a little
temporary safety deserve neither" -- Benjamin Franklin
------------------------------------------------------------
