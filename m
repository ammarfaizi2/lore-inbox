Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266929AbSK2Byo>; Thu, 28 Nov 2002 20:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266930AbSK2Byo>; Thu, 28 Nov 2002 20:54:44 -0500
Received: from zork.zork.net ([66.92.188.166]:64235 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S266929AbSK2Byn>;
	Thu, 28 Nov 2002 20:54:43 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG] [2.5.49] symbol_get doesn't work
References: <20021128234536.DC53A2C113@lists.samba.org>
	<buohee16u19.fsf@mcspd15.ucom.lsi.nec.co.jp>
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Message-Flag: Message text advisory: DISHONOURABLE INTENTIONS, STARKISM(S)
X-Mailer: Norman
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Alameda: : WHY DOESN'T ANYONE KNOW ABOUT ALAMEDA?  IT'S RIGHT NEXT TO
 OAKLAND!!!
Organization: The Emadonics Institute
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Fri, 29 Nov 2002 02:02:05 +0000
In-Reply-To: <buohee16u19.fsf@mcspd15.ucom.lsi.nec.co.jp> (Miles Bader's
 message of "29 Nov 2002 10:31:30 +0900")
Message-ID: <6uel955e1u.fsf@zork.zork.net>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  Miles Bader quotation:

> Rusty Russell <rusty@rustcorp.com.au> writes:
>> > > int *ptr = symbol_get(their_integer);
>> > > if (!ptr) ...
>>
>> That's because it's a new primitive.  Very few places really want to
>> use it, they usually just want to use the symbol directly.  However,
>> there are some places where such a dependency is too harsh: it's more
>> "if I can get this, great, otherwise I'll do something else".
>
> I find the name a bit wierd, BTW -- it sounds like it's going to return
> the _value_ of the symbol.  How about something like `symbol_addr' instead?

Surely the value of a symbol is precisely that: an address.

-- 
 /                          |
[|] Sean Neakums            |  Questions are a burden to others;
[|] <sneakums@zork.net>     |      answers a prison for oneself.
 \                          |
