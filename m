Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264522AbTCYUP5>; Tue, 25 Mar 2003 15:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264523AbTCYUP5>; Tue, 25 Mar 2003 15:15:57 -0500
Received: from mail.gmx.de ([213.165.65.60]:45283 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S264522AbTCYUPw>;
	Tue, 25 Mar 2003 15:15:52 -0500
Date: Tue, 25 Mar 2003 21:26:53 +0100
From: Marc Giger <gigerstyle@gmx.ch>
To: Stephen Frost <sfrost@snowman.net>
Cc: davidsen@tmr.com, tduffy@afara.com, linux-kernel@vger.kernel.org,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>, Eli Carter <eli.carter@inet.com>
Subject: Re: Deprecating .gz format on kernel.org aka BogoMips
Message-Id: <20030325212653.3eeab584.gigerstyle@gmx.ch>
In-Reply-To: <20030325163402.GO18434@ns.snowman.net>
References: <1048183475.3427.112.camel@biznatch>
	<Pine.LNX.3.96.1030325110027.1437B-100000@gatekeeper.tmr.com>
	<20030325163402.GO18434@ns.snowman.net>
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Your little BogoMips "contest" made me curious..:-) I've build a ELKS Kernel for my old 8088 PC. After some trouble with booting and root disks I can tell you the result now:

In "Turbo";-) mode I got 0.64 BogoMips (~8Mhz)
In "Normal" mode I got 0.37 BogoMips (~4Mhz)

Have you ever seen such a fast machine? :-))

greets

Marc

On Tue, 25 Mar 2003 11:34:02 -0500
Stephen Frost <sfrost@snowman.net> wrote:

> * Bill Davidsen (davidsen@tmr.com) wrote:
> > On Thu, 20 Mar 2003, Thomas Duffy wrote:
> > 
> > > On Thu, 2003-03-20 at 09:51, Eli Carter wrote:
> > > > So, who can beat his 15.10 bogomips?
> > > 
> [...]
> > > bogomips        : 12.44
> > 
> > At one point I ran Linux on a 386SX-16 with 12MB. That machine ran 1.2.13
> > (IIRC) until Dec 31 1999, when I was afraid it was not Y2k hardened. I
> > still see spam to glacial.tmr.com today. The name was NOT because it was
> > so cool ;-)
> > 
> > I may still have that board, but I'm not about to put it back in service
> > to measure speed. Your firewall is the slowest "real machine" I've seen,
> > emulation and embedded machines are not really general purpose.
> 
> If we're really curious...
> 
> sfrost@ns2:/home/sfrost> cat /proc/cpuinfo
> processor       : 0
> vendor_id       : unknown
> cpu family      : 4
> model           : 0
> model name      : 486
> stepping        : unknown
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : no
> cpuid level     : -1
> wp              : yes
> flags           :
> bogomips        : 9.42
> 
> This is my secondary name server.  This was also after an upgrade from
> a 386 because bind9 is a bloody pig. :)  To be honest I've thought about
> putting the 386 back in service as something else because unlike my web
> server and primary name server there's no chance a CPU fan on it is
> going to die causing a CPU to fry and the system to crash.  At one point
> the 386 had a 630 day uptime, running 2.2.16.
> 
> 	Stephen
> 
