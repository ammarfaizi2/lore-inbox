Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267039AbTCFASd>; Wed, 5 Mar 2003 19:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267050AbTCFASd>; Wed, 5 Mar 2003 19:18:33 -0500
Received: from mx2.it.wmich.edu ([141.218.1.94]:5514 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id <S267039AbTCFASc>;
	Wed, 5 Mar 2003 19:18:32 -0500
Message-ID: <3E66964E.6050101@wmich.edu>
Date: Wed, 05 Mar 2003 19:29:02 -0500
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030206
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Con Kolivas <kernel@kolivas.org>,
       Herman Oosthuysen <Herman@WirelessNetworksInc.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux vs Windows temperature anomaly
References: <20030303123029.GC20929@atrey.karlin.mff.cuni.cz> <p05210507ba8c20241329@[10.2.0.101]> <3E66842F.9020000@WirelessNetworksInc.com> <200303061038.44872.kernel@kolivas.org> <20030305235057.M20511@flint.arm.linux.org.uk>
In-Reply-To: <20030305235057.M20511@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Thu, Mar 06, 2003 at 10:38:44AM +1100, Con Kolivas wrote:
> 
>>On Thu, 6 Mar 2003 10:11 am, Herman Oosthuysen wrote:
>>
>>>Linux is more 'busy' than windoze and I have heard of boxes frying when
>>>running Linux.   The solution is to find a better motherboard
>>>manufacturer...
>>
>>That doesn't make sense. His post said the temperature was 20 degrees lower 
>>when it failed.
> 
> 
> It makes perfect sense.  Components drawing power produce heat, which
> causes a temperature rise above ambient.  Put simply, if a chip that
> fails at a case temperature of 50C and you have a 10C rise, it'll fail
> at 40C. If you have a 20C rise, it'll fail at 30C.
> 
> PS, the efficiency of heatsinks is measured in degC/W - how many degrees
> celcius the temperature rises for each watt of power dissipated.  Double
> the dissipated power, double the temperature rise.
> 


that doesn't make much sense.

a chip for a given power output fails at a certain chip temperature, 
this temperature doesn't vary by the case temp.  If the case temp 
increases then the chip temp will increase as long as the cooling system 
on the chip doesn't change. Hence if the case temp increases the chip 
temperature will increase and that could put it into the range of 
failure.  If the case temp decreases then the chip temp decreases.

The behavior you describe is when you increase the power output of a 
chip beyond normal specifications (overclocking) then the temperature of 
failure is lowered.  eg. A chip that would run normally at 50C now can 
only run stable at 45-40.

chip temp sensors are usually located in a relatively cool area of the 
chip, hence chip failure temps occur usually around 60C (max)  when in 
fact it's around 80-90C. Unfortunately for us, chip temperature is not 
uniform across the chip.

Here is a nice little site to get some info on that stuff.
http://users.erols.com/chare/elec.htm


that being said.
I've never heard of running linux frying someone's cpu. I could see 
frying a power supply because cheap power supplies will fail after a 
while of idle/load cycles that linux is good at using. I really dont see 
how else linux could be more "busy" than winows especially since windows 
has 5 or 6 spyware ad programs running behind the scenes all the time 
anyway and the virus scanner having to check every instruction would 
definitly lead to a higher cpu average than a linux box ding the same 
things minus the spyware and virus scanner.  It just doesn't make any 
sense. Erroring out more in linux than windows...possibly yes depending 
on which version but not hardware damage under normal use.


