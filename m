Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbQLXKQf>; Sun, 24 Dec 2000 05:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129370AbQLXKQZ>; Sun, 24 Dec 2000 05:16:25 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:33039 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129319AbQLXKQR>; Sun, 24 Dec 2000 05:16:17 -0500
Message-ID: <3A45C5AA.D0A5FDF3@t-online.de>
Date: Sun, 24 Dec 2000 10:45:14 +0100
From: Jeffrey.Rose@t-online.de (Jeffrey Rose)
Organization: http://ChristForge.SourceForge.net/
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Michael Chen <michaelc@turbolinux.com.cn>, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: About Celeron processor memory barrier problem
In-Reply-To: <4015029078.19991223172443@turbolinux.com.cn> <Pine.LNX.4.10.10012230920330.2066-100000@penguin.transmeta.com> <20001224002732.O25239@arthur.ubicom.tudelft.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw wrote:
> 
> On Sat, Dec 23, 2000 at 09:21:51AM -0800, Linus Torvalds wrote:
> > A Celeron isn't a PIII, and you shouldn't tell the configure that it is.
> 
> Well, some Celerons are. My laptop has a Celeron with a Coppermine
> core, so it is PIII based. Here is the output from /proc/cpuinfo:
> 
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 8
> model name      : Celeron (Coppermine)
> stepping        : 1
> cpu MHz         : 501.140
> cache size      : 128 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
> bogomips        : 999.42

I also have a Celeron 600 in my Compaq 5000, but even with the output
below, I am not sure this is what Linus is talking about! I believe
Linus is trying to say, "We HAVE configurations set for that specific
architecture, so please USE them." However, I suppose you are saying you
will get better performance from selecting PIII due to this output? Let
me know ...

jrose$ cat /proc/info 

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Celeron (Coppermine)
stepping	: 3
cpu MHz		: 598.064
cache size	: 128 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat
pse36 mmx fxsr sse
bogomips	: 1192.76

Cheers,

Jeff
-- 
<Jeffrey.Rose@t-online.de>
KEYSERVER=wwwkeys.de.pgp.net
SEARCH STRING=Jeffrey Rose
KEYID=6AD04244
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
