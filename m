Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbVHNBTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbVHNBTU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 21:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbVHNBTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 21:19:20 -0400
Received: from smtpout.mac.com ([17.250.248.89]:32484 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751367AbVHNBTT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 21:19:19 -0400
In-Reply-To: <1123981065.14138.29.camel@localhost.localdomain>
References: <42FDE286.40707@v.loewis.de> <feed8cdd0508130935622387db@mail.gmail.com> <1123958572.11295.7.camel@mindpipe> <20050813184951.GA8283@carfax.org.uk> <1123959201.11295.9.camel@mindpipe> <1123981065.14138.29.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <896E8B77-FD22-4898-BFE5-559936B8040E@mac.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Hugo Mills <hugo-lkml@carfax.org.uk>,
       Stephen Pollei <stephen.pollei@gmail.com>,
       =?ISO-8859-1?Q? "Martin_v._L=F6wis" ?= <martin@v.loewis.de>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [Patch] Support UTF-8 scripts
Date: Sat, 13 Aug 2005 21:19:02 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 13, 2005, at 20:57:45, Alan Cox wrote:
>>>    I have "setxkbmap -symbols 'en_US(pc102)+gb'" in my ~/.xsession,
>>> and « and » are available as AltGr-z and AltGr-x respectively.
>>
>> Most keyboards don't have an AltGr key.
>
> You must be an American. Most old the worlds keyboards have an AltGr
> key. You'll find that US keyboards have two alt keys to avoid  
> confusing
> people (like one button mice ;)) but the right one is understood by  
> the
> X bindings to be "AltGr". Even though the US keyboard is apparently
> lacking functionality its purely a text label issue

And those of us who are Mac OS X oriented have patched our console and X
keycodes to match the mac way of generating symbols:

Alt-\        = «
Alt-Shift-\  = »
Alt-Shift-+  = ±

If only someone could come up with a good character palette like exists
on that OS, something that could generate a wide variety of keysyms,
preferably all of UTF-8, and send them to the topmost window.

Cheers,
Kyle Moffett

--
Unix was not designed to stop people from doing stupid things,  
because that
would also stop them from doing clever things.
   -- Doug Gwyn


