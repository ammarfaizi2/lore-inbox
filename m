Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263411AbTDCPLj>; Thu, 3 Apr 2003 10:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263415AbTDCPLj>; Thu, 3 Apr 2003 10:11:39 -0500
Received: from twister.ispgateway.de ([62.67.200.3]:12 "HELO
	twister.ispgateway.de") by vger.kernel.org with SMTP
	id <S263411AbTDCPLh>; Thu, 3 Apr 2003 10:11:37 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Much better framebuffer fixes.
References: <20030402221008$2d6c@gated-at.bofh.it>
        <20030402221008$69b9@gated-at.bofh.it>
From: Lars Noschinski <lars@usenet.noschinski.de>
Date: Thu, 03 Apr 2003 17:25:52 +0200
In-Reply-To: <20030402221008$69b9@gated-at.bofh.it> (James Simmons's message
 of "Thu, 03 Apr 2003 00:10:08 +0200")
Message-ID: <87u1dfiovz.fsf@vetinari.home.noschinski.de>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) XEmacs/21.4 (Common Lisp,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons <jsimmons@infradead.org> writes:
>> Doesn't work for my Radeon 9100, as I get a kernel panic. As of 2.5.66
>> the Radeon 9100 is not supported, I run a slightly modified version
>> (diff to 2.5.66 appended). At least the framebuffer seems to work,
>> till now I had now time for further tests.
>
> I applied your patch. With your patch plus my it does work perfectly find
> for you?

With both patches, the kernel panics at boot time. With only my patch,
the framebuffer is initialised at 640x480. Console switching and X
work perfectly.

But if I try to change the video mode with fbset 2.1, the screen wents
blank after a console switch. I found no way to change resolution at
boot time ("video=radeon:1024x768-32@85" for example did not work).

