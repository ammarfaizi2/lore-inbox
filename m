Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285589AbSAAVjX>; Tue, 1 Jan 2002 16:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285574AbSAAVjO>; Tue, 1 Jan 2002 16:39:14 -0500
Received: from mercury.ccmr.cornell.edu ([128.84.231.97]:34578 "EHLO
	mercury.ccmr.cornell.edu") by vger.kernel.org with ESMTP
	id <S285135AbSAAVjA>; Tue, 1 Jan 2002 16:39:00 -0500
From: Daniel Freedman <freedman@ccmr.cornell.edu>
Date: Tue, 1 Jan 2002 16:38:55 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: ATHLON HELP ME ON THIS PLZ!!!!
Message-ID: <20020101163855.F27565@ccmr.cornell.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <000901c192fc$66df2b00$d500a8c0@mshome.net> <200201012107.QAA10138@mah21awu.cas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200201012107.QAA10138@mah21awu.cas.org>; from mharrold@cas.org on Tue, Jan 01, 2002 at 04:07:52PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Mike and Astinus,

On Tue, Jan 01, 2002, Mike Harrold wrote:
> > 
> > I know i have been posting too many questions on this subject and i also
> > know that these athlon issues were deeply discussed some week ago.
> > So i went back and READ ALL the posts concerning dual athlon machines and
> > even chipsets! But my dought remains.
> > 
> > I am about to buy a dual athlon pc, a tyan's thunder k7 S2462 ( 760mp ) and
> > two 1800 or 1700 ahtlon MP processors.
> > I will buy the registered DDram supported or advised by tyan's manufacturer
> > as well as a good power supply and some major cooling.
> > 
> > My main question is:    Am i going to have any kind of problems when trying
> > to run a SMP kernel???
> 
> Actually, I'm interested in this as well. The only thing stopping me from
> buying a dual Athlon MP is the problems I keep reading about here on lkml.
> I don't want to spend the money only to have problems.
> 
> So, if anyone is running dual Athlon MPs *flawlessly*, I'd appreciate a
> hardware listing (MB, Bios version, RAM type & manufacturer, etc.).

As I've mentioned before, I'm running ten dual Athlon systems with
perfect stability for the past few months, and reboots only for kernel
upgrades or power supply failures that exceeded our UPS backup supply.a

The hardware of relevance:

Tyan S2460 motherboard (though you may want to wait for Tyan S2466
(release time unknown: a month? two?) which has the 760MPX with 66MHz
64-bit PCI, the S2460 only has 64-bit 33MHz PCI)

Dual Athlon MP 1800+'s processors on some nodes and Dual Athlon MP 1.2
GHz on others (clearly never mixing the two on the same machine)

2GB of Corsair ECC/Reg. DDR2100 Ram per node (4 512MB sticks) (one
machine has 4GB of Corsair memory and works perfectly except for the
inability of the board's BIOS to address the last 400MB or so (some
type of AGP Video offset or the like.  grr...))

BIOS version is Tyan's 1.03, but I never had problems with the initial
1.02 other than the fact that it didn't POST with headless nodes (no
video cards) which was annoying...

Can't see how much else matters, but if you're interested:

Non-diskless machines are used as workstations and also have IBM 60GXP
(40GB) drive and ATI xPERT 2000 video cards.

Power supplies in workstations are Antec 400 watt supplies bundled
with the Antec sx1040.  PSU's in the nodes are Zippy Emacs
P2U-6300P's.

NIC's are Intel EEPro 100+ management adapters (PILA8460B).



These machines get their memory and FPU systems beat on quite hard,
from my point of view, as they run intensive physics calculations
(specifically, DFT electronic structure calculations) 24/7.  So my
claims to their stability are not based upon non-activity of the
machines.  Obviously, YMMV...




Separately...

On Tue, Jan 01, 2002, Astinus wrote:
> Can anyone explian me why almost every body, even quite big servers bought
> athlon xps instead of the mp ones^??
> This is an issue that concerns me too!! You see,  ~why would a big server
> risk to buy a processor that may not work when the other one (mp) is suppose
> to work?? Is it for the extraa dollars u have to spend on the hardware???

I would be VERY suprised if any significant portion of those running
"big servers" bought XP's instead of MP's for dual use.  I mainly
think it's an enthusiast thing, which is fine...  You have to make
your own tradeoffs between cost/assurances for your specific use.

> Am I w~rong?? Are the MPs and the XPs so similar that the problems u have
> with one will be the same with the other???
>
> I would like some opinions on this.

IMHO, I would NOT buy XP to use in a dual configuration, but that's
only because I value the assurance of proper SMP operation to be worth
the extra ~$100 per CPU ($200 per machine), and not because there are
not reports of dual XP's working (but working how? what about at
higher loads? with more memory?  etc...)

> I never had an AMD machine but with the current performance of  this
> manufacturer's material  i was willing to change intel for AMD.
> What i don't want is to spend my cash ~in a machine that i will hate for the
> rest of  its life :P.

I think you'll enjoy the Athon MP platform very much (maybe even more
with new 760MPX chipset).


HTH and take care,

Daniel

-- 
Daniel A. Freedman
Laboratory for Atomic and Solid State Physics
Department of Physics
Cornell University
