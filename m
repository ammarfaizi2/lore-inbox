Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313592AbSDMOZo>; Sat, 13 Apr 2002 10:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313593AbSDMOZn>; Sat, 13 Apr 2002 10:25:43 -0400
Received: from [195.63.194.11] ([195.63.194.11]:54541 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313592AbSDMOZm>; Sat, 13 Apr 2002 10:25:42 -0400
Message-ID: <3CB8314E.7050707@evision-ventures.com>
Date: Sat, 13 Apr 2002 15:23:26 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Vojtech Pavlik <vojtech@suse.cz>, Petr Vandrovec <vandrove@vc.cvut.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: VIA, 32bit PIO and 2.5.x kernel
In-Reply-To: <20020412001029.GA1172@ppc.vc.cvut.cz> <20020412102021.A18037@ucw.cz> <3CB694FC.2060701@evision-ventures.com> <20020413111229.B19090@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Fri, Apr 12, 2002 at 10:04:12AM +0200, Martin Dalecki wrote:
> 
>>3. Make 32 bit PIO transfers the global default.
> 
> 
> This is fine, as long as you allow some interfaces to say "I really want
> to be 16-bit PIO only".
> 
> I *need* 16-bit transfers for many ARM-based IDE stuff.  32-bit is not
> an option on many, if not all ARM-based PCMCIA stuff.

What I wan't to disable is just the *unconditional* fallback to 16 bit IO
at some places. This and not more. This doens't even affect the physical setup 
between the host chip and the controller on disc.
The global "wheee I'm a poor and can't afford 32 bit IO" option will remain
there of course.

So we have no  issue here. OK?

