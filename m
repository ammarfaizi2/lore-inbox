Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272266AbRHXPmw>; Fri, 24 Aug 2001 11:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272183AbRHXPmo>; Fri, 24 Aug 2001 11:42:44 -0400
Received: from smtp3.cern.ch ([137.138.131.164]:17605 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S272190AbRHXPmg>;
	Fri, 24 Aug 2001 11:42:36 -0400
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
In-Reply-To: <E15a1rW-000MM9-00@f10.mail.ru> <20010823143443.F14302@cpe-24-221-152-185.az.sprintbbd.net> <d3ofp5wr46.fsf@lxplus035.cern.ch> <20010824083728.J14302@cpe-24-221-152-185.az.sprintbbd.net>
From: Jes Sorensen <jes@sunsite.dk>
Date: 24 Aug 2001 17:42:47 +0200
In-Reply-To: Tom Rini's message of "Fri, 24 Aug 2001 08:37:28 -0700"
Message-ID: <d31ym1wjk8.fsf@lxplus035.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Tom" == Tom Rini <trini@kernel.crashing.org> writes:

Tom> On Fri, Aug 24, 2001 at 02:59:37PM +0200, Jes Sorensen wrote:
>>  Again, please try and do real porting work before you make such
>> silly statements. Perl is 32/64 little/big-endian clean ... and
>> still it's the absolutely worst app to bring up (even X tends to be
>> easier).

Tom> perl is (or was last time I tried it) a PITA because it doesn't
Tom> have a real config script.  In my experiance (and I do have a lot
Tom> here) apps which use autoconf/et al suck less at porting, as long
Tom> as you have autoconf/libtool/et al happy.  Then it usually comes
Tom> down to poorly written code.

The configure script has almost nothing to do with this! autoconf
etc. is just little bits on the surface. So pardon if I question the
relevance of your experience in this area.

The real problems with Perl is that it exercises almost all of your
libc, uses floating point math, dlopen() and a lot of other
funnies. Successfully running Perl's test suite is a very good
indicator for the completeness of your libc. On the other hand gcc and
the development toolchain are remarkably easy to accomodate on that
front.

Jes
