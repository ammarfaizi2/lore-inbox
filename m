Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbUJXBEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbUJXBEl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 21:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbUJXBEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 21:04:40 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:52120 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261350AbUJXBEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 21:04:36 -0400
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
From: Lee Revell <rlrevell@joe-job.com>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041022010212.53117f35@mango.fruits.de>
References: <4176E08B.2050706@techsource.com>
	 <20041022010212.53117f35@mango.fruits.de>
Content-Type: text/plain
Date: Sat, 23 Oct 2004 21:04:34 -0400
Message-Id: <1098579874.29081.135.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-22 at 01:02 +0200, Florian Schmidt wrote:
> Maybe a graphics card is too coslty to develop and implement. I would really
> like to see such a project for an open soundcard. I mean how expensive can
> it be to slap a dsp plus some DA/AD's on a pci board? A simple 4in/4out card
> doing up to 48/16 or even 96/24 could probably be developed much cheaper
> than a graphics card. And it could serve as a test on how people would react
> to such an "open" hardware product.

I think Florian is on to something.  The market for pro audio hardware
is WAY more forgiving than 3D cards.  There are many, many smaller
companies doing quite well.  This is still a business where some guy in
his garage in Utah (MetaSonix) designs and builds effects pedals by
hand, and a band like U2 will hear one somewhere and immediately send
their people down to scoop up every MetaSonix box in NYC...  Unlike in
the computer industry, people are not easily fooled by hype and
marketing, they are professionals and know what sounds good.

The big players are companies like DigiDesign and MoTU, where what
people really need is the software, but they bundle it with
sometimes-good, sometimes-bad, always-overpriced hardware so it's a
little harder to figure out how hard you are being screwed.  The
DigiDesign Mbox for example is the absolute entry-level Pro Tools rig.
It consists of a crappy USB (!) sound interface, 2 in/2 out, no DSP,
plus a dumbed down version their software of course, and they charge
like $450 for it.  If you want something decent, say a FireWire
interface with analog pres and a SHARC DSP, you are looking at
$800-2000.

They are making money hand over fist.  A good chunk of the market is
people who _need_ a DAW, and cost is often no object.  Even the most
Luddite recording engineers, people who master to analog tape and get
their vocal sound by plugging the mic into a crappy guitar amp, have to
use Pro Tools to edit and track because the alternative is things like
"window edits", where you literally cut out a square of tape with a
razor to splice in a new take.

Ever heard of an "iLok" aka a "Pro Tools Key"?  It's a USB
authentication key that you can buy at almost any music store.  Because,
of course, once you have the Pro Tools rig, if you want to do things
like sync to SMPTE, or import another file format, please insert your
key and have your credit card ready...

I could go on and on, but I think you get the picture - there is a huge
market out there, dominated by crappy software, bundled with good
hardware.  It's like if the Microsoft tax were 75%.  On the other hand
there is a lot of _amazing_ proprietary software that is not tied to any
hardware.  And of course there are some great Linux audio apps.
Unfortunately there is no "open" audio hardware available, and currently
with the exception of RME Linux audio users are mostly stuck with the
low end stuff.

For example, no FireWire audio interfaces are supported, because the
people who make them make WAY too much money selling software upgrades.
So we are stuck reverse engineering consumer and semi-pro soundcards.
The ALSA developers are too busy fixing stupid bugs caused by the
chronic lack of docs for crappy integrated sound hardware, and vendors
who release completely different and incompatible variations of their
cheap laptop AC97 card, just to make it a few cents cheaper...  no one
has had the time, inclination, and ability to reverse engineer a real
device.  Besides, reverse engineering even simple devices like sound
cards is a losing battle, as soon as you figure it out then hardware
makers find some new corner to cut...

If there were one decent, sub-$500 piece of open sound hardware (no
offense to RME but they are definitely at the high end of the market) it
would sell like hotcakes.  People on LAU would be lining up around the
block, Windows and Mac users too.  There are more than a few would-be
Linux audio systems integrators, who _know_ they could do better than
the proprietary folks, but are waiting for any acceptable hardware to
become available.

How much would a 6in/6out FireWire interface, with XLR and 1/4"
connections on the chassis or via a dongle, decent DA/AD converters, and
a SHARC DSP cost to produce?  A guitar level input with trim, like on
the old Tascam 4-tracks, would be a very nice feature; many cards claim
you can plug a guitar into them but the impedance is wrong.  You could
offer a version with more DSP power, and worse quality DAC/ADC, for low
powered/embedded/stomp box apps, and maybe one with better converters
and less DSP power for high end systems. 

Anyway, my point is that Nvidia and ATI are very, very good at what they
do.  Digi & their ilk were the first to market, made a killing and are
now fat and lazy and resting on their laurels, just begging to be taken
down...

;-P

Lee


