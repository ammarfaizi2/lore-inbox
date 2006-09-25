Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751506AbWIYWKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbWIYWKX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 18:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWIYWKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 18:10:23 -0400
Received: from spirit.analogic.com ([204.178.40.4]:8708 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751506AbWIYWKW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 18:10:22 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 25 Sep 2006 22:10:10.0789 (UTC) FILETIME=[5E247150:01C6E0EF]
Content-class: urn:content-classes:message
Subject: Re: GPLv3 Position Statement
Date: Mon, 25 Sep 2006 18:10:07 -0400
Message-ID: <Pine.LNX.4.61.0609251728310.16401@chaos.analogic.com>
In-Reply-To: <200609251658.08058.gene.heskett@verizon.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: GPLv3 Position Statement
thread-index: Acbg714wV00CG9bHTwSGaQydYVpkkQ==
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com> <17687.46268.156413.352299@cse.unsw.edu.au> <1159194447.2899.66.camel@mindpipe> <200609251658.08058.gene.heskett@verizon.net>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Gene Heskett" <gene.heskett@verizon.net>
Cc: <linux-kernel@vger.kernel.org>, "Lee Revell" <rlrevell@joe-job.com>,
       "Neil Brown" <neilb@suse.de>,
       "Michiel de Boer" <x@rebelhomicide.demon.nl>,
       "James Bottomley" <James.Bottomley@steeleye.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 25 Sep 2006, Gene Heskett wrote:

> On Monday 25 September 2006 10:27, Lee Revell wrote:
>> On Mon, 2006-09-25 at 20:51 +1000, Neil Brown wrote:
>>> Tolerance of binary blogs seems to be steadily dropping.
>>>
>>> As far as I can tell, the DVD-CSS is purely a legal issue today - the
>>> technical issues are solved (I can watch any-region on my Linux
>>> computer, and in Australia, the law requires that all DVD players must
>>> ignore region encoding as it is an anti-competitive practice).
>
> I suspect thats history now, with the DMCA proposals now being voted on
> there.
>
>> Tolerance by who?  As far as I can tell tolerance for binary blobs by
>> the typical Linux desktop user is higher than ever.
>
> Generaly speaking, from someone way up in the top level of the bleacher
> seats here, thats true, as for instance the ndiswrapper scenario, required
> by the rules of the various radio spectrum regulating agencies around the
> planet.  They would never, ever, give approval to a driver that was 100%
> open source because of the ease with which the open source coder could
> make them illegal, either for frequencies used, or for the Transmitter
> Power Output one of these software radios COULD be made to do.

Actually no. I've now heard this false information too many times.
As somebody who has prepared over 40 applications for FCC Type
Acceptance, and submitted monitoring equipment for FCC Type
Approval, I have first-hand experience. If somebody was so dumb as
to disclose to the FCC that a hacker could make the equipment unsuitable
for its intended use, the FCC would not allow the equipment to be used.
No certification would be forthcoming. On the other hand, if part
of the "turning-on" process was to load some bits from a bucket, this
disclosure must be part of the approval process. The FCC just might
require that the bits be checked for integrity, perhaps a checksum
or CRC.

Also, you can't adjust a milliwatt transmitter to produce a megawatt,
no matter how hard you try. The power output is allowed to be reduced
by software below the authorized maximum for that class of service.
You'd do much better at getting more power out by designing a custom
antenna coupling circuit so that the fixed output voltage could be fed
to a lower output impedance. Then you'd eventually run into fold-back
and overheating of those tiny RF transistors.

It's most likely, however, that a complete disclosure of the device
to be operated has not been made at all! Disclosing that a complete
disclosure has not been made, when in fact it's required, could
result in not only the loss of approval, but in fines as well.

Further, you can look at the disclaimer (the FCC Label) on any item
that had to be approved. It states quite clearly that modifications
render the device unapproved.

As for frequencies, the pseudo-random frequency-hop needs a center-
frequency that's pretty much set in stone (actually a quartz one).
Anybody can change quartz crystals. Again, modifications remove
approval. The typical user can operate unapproved equipment at
his own peril. However, it's unlikely that they will be caught
unless they leave their modified device on the lawn of the FCC's
standards office in Laurel, MD.

It's all moot. The device manufacturers don't want the competition
to know what's in those bits so their nature is not going to be
disclosed. Further, even if they provided the FPGA "source-code"
it's unlikely that most people would be able to use it at all.
Single-seat licenses for much of that stuff costs over US$500.00 -just
a bit too much to hack a US$39.99 device.

However, if you are a (choose your country) clone manufacturer,
it would be a pretty good deal to buy a US$39.99 board as a sample,
buy a US$500.00 software license, then clone 10,000 of these, selling
them at US$29.99 a pop. That's a US$300k profit for a US$539.99
investment and that's why you are not going to get the source-code!

>
>> They consider it a
>> bug if their distro does not automagically install the nvidia/ATI
>> drivers, and immediately write you off as a GPL zealot if you even
>> mention that a tainted kernel cannot be debugged.
>
> No, I do not, and never have said too much about it (as if anyone would
> listen to me anyway) unless I was pissed because the kernels available
> driver was obviously broken and caused crashes etc.  We DO understand,
> very well, that troubleshooting a problem just isn't possible when the
> srcs are not available, meaning there is no way in hell you can certify
> that the tainting driver didn't scribble all over memory it has no
> business scribbling into.
>
> Begin rant:
>
> Yeah, we'ed be fools to say we don't have a political agenda when we're
> forced to use substandard or questionably legal means for reasons related
> to the above.  But give us credit for understanding the reasons.  What we,
> the users, need in many cases, is a contact address to address our vents
> to, for instance for someone at broadcom, high enough to have meaningfull
> input to the discussions in the board room, that we could mail-bomb with
> requests for better support.  If 3000+ people who bought their stuff with
> some well known makers label on it, like HP, and found they couldn't use
> that builtin radio and do it 100% legal and compatibly, would email (and
> Cc: your countries regulatory agency too) that chip maker and gently but
> firmly bitch, that bit of 'politics' might well bring about some
> constructive change in broadcoms (and the regulatory agencies involved)
> attitude vis-a-vis specs release so better drivers could be written.
>
> End rant.
>
> --
> Cheers, Gene
> "There are four boxes to be used in defense of liberty:
> soap, ballot, jury, and ammo. Please use in that order."
> -Ed Howdershelt (Author)
> Yahoo.com and AOL/TW attorneys please note, additions to the above
> message by Gene Heskett are:
> Copyright 2006 by Maurice Eugene Heskett, all rights reserved.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.66 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
