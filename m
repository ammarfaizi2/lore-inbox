Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136442AbREGRVi>; Mon, 7 May 2001 13:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136437AbREGRV2>; Mon, 7 May 2001 13:21:28 -0400
Received: from a1a90191.sympatico.bconnected.net ([209.53.18.14]:13696 "EHLO
	a1a90191.sympatico.bconnected.net") by vger.kernel.org with ESMTP
	id <S136407AbREGRVN>; Mon, 7 May 2001 13:21:13 -0400
Date: Mon, 7 May 2001 10:20:53 -0700
From: Shane Wegner <shane@cm.nu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, jerdfelt@valinux.com
Subject: Re: 2.2.20pre1: Problems with SMP
Message-ID: <20010507102053.A2276@cm.nu>
In-Reply-To: <20010506175050.A1968@cm.nu> <E14wiNn-0003JF-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <E14wiNn-0003JF-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, May 07, 2001 at 11:36:49AM +0100
Organization: Continuum Systems, Vancouver, Canada
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2001 at 11:36:49AM +0100, Alan Cox wrote:
> > Just booted up 2.2.20pre1 and am getting some funny
> > results.  The system boots but is very slow.  Every few
> > seconds I get:
> > Stuck on TLB IPI wait (CPU#0)
> > 
> > Booting vanilla 2.2.19 works fine.  The machine is an
> > Intel Pentium III 850MHZ on an Abit VP6 board.  If any
> > further information is needed, let me know.
> 
> Can you back out the change to io_apic.c and tell me if that fixes it. If so
> let Johannes Erdfelt and I know.

That does indeed correct the problem.  2.2.20pre1 now works
as expected.

Shane

-- 
Shane Wegner: shane@cm.nu
              http://www.cm.nu/~shane/
PGP:          1024D/FFE3035D
              A0ED DAC4 77EC D674 5487
              5B5C 4F89 9A4E FFE3 035D
