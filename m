Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313584AbSDMKQ2>; Sat, 13 Apr 2002 06:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313585AbSDMKQ1>; Sat, 13 Apr 2002 06:16:27 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:20620 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S313584AbSDMKQ1>;
	Sat, 13 Apr 2002 06:16:27 -0400
Date: Sat, 13 Apr 2002 12:15:58 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Vojtech Pavlik <vojtech@suse.cz>, Petr Vandrovec <vandrove@vc.cvut.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: VIA, 32bit PIO and 2.5.x kernel
Message-ID: <20020413121558.A24023@ucw.cz>
In-Reply-To: <20020412001029.GA1172@ppc.vc.cvut.cz> <20020412102021.A18037@ucw.cz> <3CB694FC.2060701@evision-ventures.com> <20020413111229.B19090@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2002 at 11:12:29AM +0100, Russell King wrote:

> On Fri, Apr 12, 2002 at 10:04:12AM +0200, Martin Dalecki wrote:
> > 3. Make 32 bit PIO transfers the global default.
> 
> This is fine, as long as you allow some interfaces to say "I really want
> to be 16-bit PIO only".
> 
> I *need* 16-bit transfers for many ARM-based IDE stuff.  32-bit is not
> an option on many, if not all ARM-based PCMCIA stuff.

Basically it should work both ways - VIA and AMD interfaces *need*
32-bit in the same manner.

-- 
Vojtech Pavlik
SuSE Labs
