Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264908AbSKOPca>; Fri, 15 Nov 2002 10:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264910AbSKOPca>; Fri, 15 Nov 2002 10:32:30 -0500
Received: from zork.zork.net ([66.92.188.166]:31141 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S264908AbSKOPc3>;
	Fri, 15 Nov 2002 10:32:29 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Moving from Linux 2.4.19 LVM to LVM2
References: <Pine.LNX.4.44.0211151012470.14891-100000@ibm-ps850.purdueriots.com>
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Message-Flag: Message text advisory: DICTO SIMPLICITER, DISHONOURABLE
 INTENTIONS
X-Mailer: Norman
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Alameda: : WHY DOESN'T ANYONE KNOW ABOUT ALAMEDA?  IT'S RIGHT NEXT TO
 OAKLAND!!!
Organization: The Emadonics Institute
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Fri, 15 Nov 2002 15:39:24 +0000
In-Reply-To: <Pine.LNX.4.44.0211151012470.14891-100000@ibm-ps850.purdueriots.com> (Patrick
 Finnegan's message of "Fri, 15 Nov 2002 10:13:19 -0500 (EST)")
Message-ID: <6uheei6dw3.fsf@zork.zork.net>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  Patrick Finnegan quotation:

> On Fri, 15 Nov 2002, Joe Thornber wrote:
>
>> On Thu, Nov 14, 2002 at 10:51:48PM -0500, Patrick Finnegan wrote:
>> > On Thu, 14 Nov 2002, Joe Thornber wrote:
>> >
>> > > On Wed, Nov 13, 2002 at 11:05:37PM -0500, Patrick Finnegan wrote:
>> > > > Is there an easy and plainless way to do this?  Are the LVM2 tools
>> > > > backwards-compatible with the old LVM?
>> > >
>> > > Yes
>> >
>> > Actually, the answer is aparently "No."  LVM2's tools don't work with a
>> > 2.4.x kernel.
>>
>> Had you applied the device-mapper patches for 2.4 ?
>
> Umm, no.  If I had, then that wouldn't be 2.4's native LVM.

The LVM1 tools require the lvm module.  The LVM2 tools require the
device-mapper module (and therfore, for 2.4, a patch).  LVM2 is
backward-compatible with LVM1 in the sense that LVM2 can use
LVM1-created volume groups.

I've been running LVM2 (I used to use LVM1) on my laptop for the past
few weeks (2.4.19, also patched with rmap14b), and it's been
completely trouble-free.

-- 
 /                          |
[|] Sean Neakums            |  Questions are a burden to others;
[|] <sneakums@zork.net>     |      answers a prison for oneself.
 \                          |
