Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266702AbTAZFk2>; Sun, 26 Jan 2003 00:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266708AbTAZFk1>; Sun, 26 Jan 2003 00:40:27 -0500
Received: from air-2.osdl.org ([65.172.181.6]:40146 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266702AbTAZFk0>;
	Sun, 26 Jan 2003 00:40:26 -0500
Message-ID: <33191.4.64.236.51.1043560176.squirrel@www.osdl.org>
Date: Sat, 25 Jan 2003 21:49:36 -0800 (PST)
Subject: Re: MB without keyboard controller / USB-only keyboard ?
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <rddunlap@osdl.org>
In-Reply-To: <33152.4.64.236.51.1043558975.squirrel@www.osdl.org>
References: <20030116120324.2b97e010.skraw@ithnet.com>
        <Pine.LNX.4.33L2.0301160805110.9551-100000@dragon.pdx.osdl.net>
        <20030123140628.3a76fdd9.skraw@ithnet.com>
        <33152.4.64.236.51.1043558975.squirrel@www.osdl.org>
X-Priority: 3
Importance: Normal
Cc: <skraw@ithnet.com>, <vojtech@suse.cz>, <linux-kernel@vger.kernel.org>,
       <alan@lxorguk.ukuu.org.uk>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> On Thu, 16 Jan 2003 08:18:04 -0800 (PST)
>> "Randy.Dunlap" <rddunlap@osdl.org> wrote:
>>
>>> I posted a patch to 2.4.20 on 2002-Dec-04 that might work for you. It's
>>> available at
>>>   http://www.osdl.org/archive/rddunlap/patches/kbc_option_2420.patch
>>>
>>> It might work for you.  If you try it out, please let me know how it does
>>> for you.
>>
>> Hello Randy,
>>
>> we checked your patch and it works as you expected, only it is not what we
>> are looking for. We would like to be able to make _one_ kernel, that can
>> be used on boards with PS/2 keyboard or USB keyboard, but without a PS/2
>> keyboard check that takes as long as it does in current version (and gives
>> _one_ warning, but not tens).
>> Do you think this is solvable?
>
> OK, I see.  I'm willing to try a few more things on this if you are willing
> to test them...are you?
>
> Is the "controller jammed" message the only one that you are seeing?

On a "jammed" system, please boot Linux with this string added to the
command line:  "kbd-reset"
and tell me if you see any other keyboard messages, such as one that
begins with "initialize_kbd:" or these:  "Keyboard timed out",
"keyboard: Timeout" or "keyboard: Too many NACKs".

Thanks,
~Randy



