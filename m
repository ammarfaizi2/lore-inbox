Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130440AbQLBV3U>; Sat, 2 Dec 2000 16:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130449AbQLBV3K>; Sat, 2 Dec 2000 16:29:10 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:19972 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130440AbQLBV3B>; Sat, 2 Dec 2000 16:29:01 -0500
Message-ID: <3A29624B.4577287A@transmeta.com>
Date: Sat, 02 Dec 2000 12:57:47 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch-2.4.0-test12-pre3] microcode update for P4 (fwd)
In-Reply-To: <Pine.LNX.4.21.0012022049430.933-100000@penguin.homenet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran Aivazian wrote:
> 
> On Sat, 2 Dec 2000, H. Peter Anvin wrote:
> 
> > Alan Cox wrote:
> > >
> > > > Please call these MSR_* instead, "IA32_*" isn't very descriptive,
> > > > besides, the preferred prefix in existing locations in the Linux
> > > > kernel is "X86_", e.g. X86_EFLAGS_IF or X86_CR4_PSE.  I think there
> > >
> > > I think I agree with Tigran's naming. These are IA32 registers not X86 ones ;)
> >
> > They are MSRs, most of all.  His naming didn't reflect that, and quite
> > frankly, I'd much rather use the names (all starting with MSR_) that the
> > Intel documentation uses.
> >
> 
> Peter,
> 
> you probably missed the message I sent to you earlier. I have already
> explained that I did use the names which Intel documentation uses. You may
> have an old (Pentium III) version of the manual but the current
> (P4) is already available (albeit a preliminary) and that is what I used
> as a guidance.
> 
> It makes sense to check the facts before stating the same wrong statement
> twice.
> 

OK, fair enough.  Let me make a new statement then: I suggest we preface
these with MSR_ anyway so we can tell what they really are.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
