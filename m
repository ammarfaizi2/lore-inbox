Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267101AbTBQP46>; Mon, 17 Feb 2003 10:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267097AbTBQP46>; Mon, 17 Feb 2003 10:56:58 -0500
Received: from zork.zork.net ([66.92.188.166]:22414 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S267101AbTBQP45>;
	Mon, 17 Feb 2003 10:56:57 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Performance of ext3 on large systems
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Message-Flag: Message text advisory: STYLE OVER SUBSTANCE, AFFIRMATION OF
 THE CONSEQUENT
X-Mailer: Norman
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Alameda: WHY DOESN'T ANYONE KNOW ABOUT ALAMEDA?  IT'S RIGHT NEXT TO
 OAKLAND!!!
Organization: The Emadonics Institute
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Mon, 17 Feb 2003 16:06:55 +0000
In-Reply-To: <1045497374.12615.1.camel@phantasy> (Robert Love's message of
 "17 Feb 2003 10:56:14 -0500")
Message-ID: <6ufzqmao2o.fsf@zork.zork.net>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2
 (i386-debian-linux-gnu)
References: <200302171529.h1HFTVPk010325@darkstar.example.net>
	<1045497374.12615.1.camel@phantasy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  Robert Love quotation:

> On Mon, 2003-02-17 at 10:29, John Bradford wrote:
>
>> > ext3 doesn't implement noatime!?  Hurg...
>
> noatime is implemented.
>
>> Actually, it makes sense in a way - noatime only speeds up reads, not
>> writes, (access time is always updated on a write), whereas a
>> journaled filesystem is presumably intended to be tuned for write
>> performance.  So, for it's intended usage, not implementing noatime
>> shouldn't be a huge problem, although it would be useful.
>
> But updating the access time _is_ a write, even if its due to a read. 
> And using 'noatime' does help, and it is implemented.  I guess Andrew's
> statement was just misinterpreted, because this is what he said.

Ah, yes.  My bad.

-- 
 /                          |
[|] Sean Neakums            | Size *does* matter.
[|] <sneakums@zork.net>     | That's why I use Emacs.
 \                          |
