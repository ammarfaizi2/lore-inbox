Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261337AbSLPUAo>; Mon, 16 Dec 2002 15:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261426AbSLPUAn>; Mon, 16 Dec 2002 15:00:43 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:28124 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S261337AbSLPUAn>;
	Mon, 16 Dec 2002 15:00:43 -0500
From: Cort Dougan <cort@fsmlabs.com>
Date: Mon, 16 Dec 2002 13:02:39 -0700
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: rth@twiddle.net, linux-kernel@vger.kernel.org
Subject: Re: 2 (minor) Alpha probs in 2.5.51
Message-ID: <20021216130239.C9431@duath.fsmlabs.com>
References: <20021216003327.GC709@gallifrey> <20021215173827.A10954@twiddle.net> <20021216124937.GE709@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021216124937.GE709@gallifrey>; from gilbertd@treblig.org on Mon, Dec 16, 2002 at 12:49:37PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had a DS10 here that had, what appeared to be, a bad crystal.  The clock
would start at about 1/2 to 3/4 the expected clock rate and over about 20
minutes would move towards what it should be at.  It appeared to overshoot
the right clock-rate and then below until the oscillations would dampen
down to the correct rate.

I was doing RTLinux work on it so a bad clock wasn't acceptable.  It lives
in the garage now since I had a another DS10 that worked right.  I never
found what was actually going wrong with it or found a fix.

I would argue, though, that the Alpha clock itself is a crazy thing and
shouldn't be expected to work right :)

} * Richard Henderson (rth@twiddle.net) wrote:
} > > arch/alpha/kernel/built-in.o(.data+0x3038): undefined reference to
} > > `cia_bwx_inw'
} > 
} > Fixed in current TOT.
} 
} Great.
} 
} > > Unknown HZ value! (831) Assume 1024.
} 
} > Dunno.  Could be your clock chip is going bad.
} 
} Don't think so; with 2.4.19 it seems to be fine, and it returns to the
} low value after restarting a kernel from MILO even without powering the
} machine down or returning to AlphaBIOS.
} 
} Dave
} 
}  ---------------- Have a happy GNU millennium! ----------------------   
} / Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
} \ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
}  \ _________________________|_____ http://www.treblig.org   |_______/
} -
} To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
} the body of a message to majordomo@vger.kernel.org
} More majordomo info at  http://vger.kernel.org/majordomo-info.html
} Please read the FAQ at  http://www.tux.org/lkml/
