Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279617AbRKAT3Q>; Thu, 1 Nov 2001 14:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279615AbRKAT25>; Thu, 1 Nov 2001 14:28:57 -0500
Received: from ns.suse.de ([213.95.15.193]:12813 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S279614AbRKAT2q>;
	Thu, 1 Nov 2001 14:28:46 -0500
Date: Thu, 1 Nov 2001 20:28:45 +0100
From: Andi Kleen <ak@suse.de>
To: kuznet@ms2.inr.ac.ru
Cc: Andi Kleen <ak@suse.de>, joris@deadlock.et.tudelft.nl,
        linux-kernel@vger.kernel.org
Subject: Re: Bind to protocol with AF_PACKET doesn't work for outgoing packets
Message-ID: <20011101202845.A10648@wotan.suse.de>
In-Reply-To: <20011101192153.A30903@wotan.suse.de> <200111011856.VAA27068@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <200111011856.VAA27068@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Thu, Nov 01, 2001 at 09:56:34PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2001 at 09:56:34PM +0300, A.N.Kuznetsov wrote:
> Hello!
> 
> > When you e.g. have a TCP sniffer it makes sense to only bind it to ETH_P_IP.
> 
> For what purpose? To add a small underdeveloped copy of BPF?

Just to have an symmetric API. Everything else is too ugly to explain 
in manpages ;)

> To summarize: I wanted to see a patch allowing to detect that
> nobody listens on outpu (or even splitting input and output ptype_all.)

That would require changing/breaking PF_PACKET, no? 

-Andi
