Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266718AbSLPMln>; Mon, 16 Dec 2002 07:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266720AbSLPMln>; Mon, 16 Dec 2002 07:41:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37893 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266718AbSLPMlm>;
	Mon, 16 Dec 2002 07:41:42 -0500
Date: Mon, 16 Dec 2002 12:49:37 +0000
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: rth@twiddle.net, linux-kernel@vger.kernel.org
Subject: Re: 2 (minor) Alpha probs in 2.5.51
Message-ID: <20021216124937.GE709@gallifrey>
References: <20021216003327.GC709@gallifrey> <20021215173827.A10954@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021215173827.A10954@twiddle.net>
User-Agent: Mutt/1.4i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 12:47:22 up 20:14,  2 users,  load average: 0.00, 0.01, 0.20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Richard Henderson (rth@twiddle.net) wrote:
> > arch/alpha/kernel/built-in.o(.data+0x3038): undefined reference to
> > `cia_bwx_inw'
> 
> Fixed in current TOT.

Great.

> > Unknown HZ value! (831) Assume 1024.

> Dunno.  Could be your clock chip is going bad.

Don't think so; with 2.4.19 it seems to be fine, and it returns to the
low value after restarting a kernel from MILO even without powering the
machine down or returning to AlphaBIOS.

Dave

 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
