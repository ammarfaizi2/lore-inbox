Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129666AbQLWQ0A>; Sat, 23 Dec 2000 11:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129761AbQLWQZu>; Sat, 23 Dec 2000 11:25:50 -0500
Received: from cm698210-a.denton1.tx.home.com ([24.17.129.59]:23044 "HELO
	cm698210-a.denton1.tx.home.com") by vger.kernel.org with SMTP
	id <S129666AbQLWQZf>; Sat, 23 Dec 2000 11:25:35 -0500
Message-ID: <3A44CAD5.70CCA0B0@home.com>
Date: Sat, 23 Dec 2000 09:55:01 -0600
From: Matthew Vanecek <linux4us@home.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: recommended gcc compiler version
In-Reply-To: <0012212320430F.02217@comptechnews> <001901c06bdf$1d6c74e0$3b42b0d1@pittscomp.com> <20001221230819.A1678@scutter.internal.splhi.com> <9209d6$7nt$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> In article <20001221230819.A1678@scutter.internal.splhi.com>,
> Tim Wright  <timw@splhi.com> wrote:
> >
> >So....
> >egcs-1.1.2 is good for either, 2.7.2 is OK for 2.2, bad for 2.4. 2.95.2 and
> >later are risky. RedHat just released a bugfixed "2.96" which is an unknown
> >quantity AFAIK. Anybody brave enough to try it should probably post their
> >results.
> 
> Note that despite my public comments about it beign a bad idea to ship
> extremely untested compilers in a major release, I actually think that
> it would be wonderful to have people who are ready to face the
> consequences to try the new 2.96.
> 
> It's not been all that widely tested, but if you kno a bit about what
> you're doing (or want to learn), gcc-2.96 _does_ potentially create
> better code, and if nobody is willing to test it, any potential bugs (be
> they in the kernel sources and triggered by a smarter compiler, or in
> the compiler itself) won't be found.
> 
> So please do try it out, but please mention the fact if you end up
> having to report a bug (it won't make your bug-report be ignored, don't
> ever worry about something like that. But i would be good to have an
> older compiler handy to correlate the bug with the compiler for sure).
> 
> In fact, I'd love to hear about experiences even with the CVS snapshots.
> I just don't like them showing up in distributions ;)
> 
>                 Linus

I've been using 2.96 for the last couple of kernel compiles, and it's
been working fine (pasting warnings and all).  This is the 2nd-to-latest
update from RH 7.0.  The only issue I have is the very occasional Signal
11--but I had those with kgcc, as well, so I don't reckon those are
compiler-related.

Right now, I have test12.  This is on my desktop machine, doing normal
desktop stuff (finances, StarOffice, Netscape, Java development, etc). 
Seems to be working well, and test12 runs *much* faster than previous
kernels...
-- 
Matthew Vanecek
perl -e 'print
$i=pack(c5,(41*2),sqrt(7056),(unpack(c,H)-2),oct(115),10);'
********************************************************************************
For 93 million miles, there is nothing between the sun and my shadow
except me.
I'm always getting in the way of something...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
