Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287425AbSCLI7N>; Tue, 12 Mar 2002 03:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293731AbSCLI7E>; Tue, 12 Mar 2002 03:59:04 -0500
Received: from p50846F82.dip.t-dialin.net ([80.132.111.130]:54757 "EHLO
	sol.fo.et.local") by vger.kernel.org with ESMTP id <S287425AbSCLI64>;
	Tue, 12 Mar 2002 03:58:56 -0500
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6 IDE 19
In-Reply-To: <E16kUED-0001GB-00@the-village.bc.nu>
	<Pine.SOL.3.96.1020311180113.13428A-100000@libra.cus.cam.ac.uk>
	<20020311230158.B3167@ucw.cz>
From: Joachim Breuer <jmbreuer@gmx.net>
Date: Tue, 12 Mar 2002 09:58:53 +0100
In-Reply-To: <20020311230158.B3167@ucw.cz> (Vojtech Pavlik's message of
 "Mon, 11 Mar 2002 23:01:58 +0100")
Message-ID: <m3d6yakvqq.fsf@venus.fo.et.local>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (Cuyahoga Valley,
 i386-redhat-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

> On Mon, Mar 11, 2002 at 06:05:36PM +0000, Anton Altaparmakov wrote:
>> On Mon, 11 Mar 2002, Alan Cox wrote:
>> > > Funny you should mention that point ... The "flagged taskfile code" is a
>> > > project to allow for NATIVE DFT support in Linux.  Nice screw job you did
>> > > to IBM.
>> > 
>> > Ok so whats native DFT and where does he (and I for that matter) read about
>> > it ?
>> 
>> DFT = Drive Fault Tolerance
>
> Hmmm, I thought it was Drive Fitness test. TLAs ...
>
> [...]
>
> Hmm. I stopped believing in the usefulness of the IBM DFT after my IBM
> drive started giving unrecoverable errors reading my swap partition and
> the DFT said that everything was OK later when I ran it ...

Happened to me *more than once*. Every single time: Drive has what
looks like "Surface Errors" to the OS, SMART thinks the drive is
dandy, DFT thinks the drive is dandy and after using the DFT "erase"
feature it would even work (on the whole surface) again. Question only
remains for how long. My dealer usually gives me a replacement disk
when I tell him "this one's bogus" even if it doesn't show any
immediate errors in DFT and similar tests, but I'm sure not everyone's
that lucky.

I don't usually bash manufacturers, but with recent (> 10GB) IBM
ATA-33+ drives I've experienced this behaviour in well above 50% of
all units I've seen. The MTBF on their SCA LVD ones doesn't make me
squirm with delight either, but those a) don't lie about being broken
and b) tend to be easier to replace.


So long,
   Joe

-- 
"I use emacs, which might be thought of as a thermonuclear
 word processor."
-- Neal Stephenson, "In the beginning... was the command line"
