Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132124AbRCYRCU>; Sun, 25 Mar 2001 12:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132122AbRCYRCK>; Sun, 25 Mar 2001 12:02:10 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:58290 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S132124AbRCYRCE>; Sun, 25 Mar 2001 12:02:04 -0500
Date: Sun, 25 Mar 2001 19:01:19 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: Alex Riesen <vmagic@users.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: ACPI power-off doesn't work on Asus CUV4X (VIA Apollo 133)
Message-ID: <20010325190119.Z11126@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20010324182516.A1255@steel> <20010324225308.Y11126@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010324225308.Y11126@nightmaster.csn.tu-chemnitz.de>; from ingo.oeser@informatik.tu-chemnitz.de on Sat, Mar 24, 2001 at 10:53:08PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 24, 2001 at 10:53:08PM +0100, Ingo Oeser wrote:
> On Sat, Mar 24, 2001 at 06:25:16PM +0100, Alex Riesen wrote:
> > As i recompiled 2.4.2-ac20 with ACPI support
> > the system cannot switch itself off.
> > I get a message "Couldn't switch to S5" if
> > try to call reboot(2).
> > At load it shows that the mode is supported.
> 
> Same with AMR P6BAP-AP and P6VAP-AP () mainboards.
> 
> Firmware supports C2 C3 S0 S1 S4 S5.
> 
> All options for acpi tried.
> 
> #define APCI_DEBUG 1 has NO effect on verbosity of messages :-(
> 
> What should I do to get more debug info?
 
Just left it in FYI, Andrew.

> I'll try backing out all changes between 2.4.0 and 2.4.2-ac20,
> because there it worked ;-)

Ok, that worked. Backing out all the changes made it shutdown
again.

Since this shouldn't by the right way to fix this problem, what
else can I do Andrew?

The BIG Problem is: This is an embedded machine, so I cannot
attach all the funny debug tools. The most thing I can do is
printk and evtl. ikdb. I have only 16MB flash disk on this
machine and it is full already :-(

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
