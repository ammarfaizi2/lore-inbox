Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263209AbTC1Xbg>; Fri, 28 Mar 2003 18:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263210AbTC1Xbg>; Fri, 28 Mar 2003 18:31:36 -0500
Received: from zork.zork.net ([66.92.188.166]:18902 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S263209AbTC1Xbe>;
	Fri, 28 Mar 2003 18:31:34 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: NICs trading places ?
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Message-Flag: Message text advisory: STARKISM(S), DICTO SIMPLICITER
X-Mailer: Norman
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Alameda: WHY DOESN'T ANYONE KNOW ABOUT ALAMEDA?  IT'S RIGHT NEXT TO
 OAKLAND!!!
Organization: The Emadonics Institute
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Fri, 28 Mar 2003 23:42:51 +0000
In-Reply-To: <Pine.LNX.4.44.0303281626260.20589-100000@mooru.gurulabs.com> (Dax
 Kelson's message of "Fri, 28 Mar 2003 16:30:20 -0700 (MST)")
Message-ID: <6ud6kbcb2c.fsf@zork.zork.net>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) Emacs/21.2 (gnu/linux)
References: <Pine.LNX.4.44.0303281626260.20589-100000@mooru.gurulabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  Dax Kelson quotation:

> On Fri, 28 Mar 2003, Dave Jones wrote:
>
>> I just upgraded a box with 2 NICs in it to 2.5.66, and found
>> that what was eth0 in 2.4 is now eth1, and vice versa.
>> Is this phenomenon intentional ? documented ?
>> What caused it to do this ?
>
> I've seen the same thing for 5+ years.  Multiple things can 
> trigger it, eg:
>
> Always having your NIC drivers compiled in, and then moving between 
> different kernel versions.
>
> Going from modular NIC drivers to compiled in drivers can bite you.
>
> Isn't life fun.

Something I have been meaning to write as soon as I get bitten by this
myself is a script that uses the "ip link set X name Y" command
(possibly in conjuction with a MAC-to-name map, or else just a simple
sort) to name the interfaces consistently.

-- 
Sean Neakums - <sneakums@zork.net>
