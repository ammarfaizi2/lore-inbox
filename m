Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273132AbRIOXvA>; Sat, 15 Sep 2001 19:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273129AbRIOXuv>; Sat, 15 Sep 2001 19:50:51 -0400
Received: from [213.96.124.18] ([213.96.124.18]:18670 "HELO dardhal")
	by vger.kernel.org with SMTP id <S273130AbRIOXuk>;
	Sat, 15 Sep 2001 19:50:40 -0400
Date: Sun, 16 Sep 2001 01:52:52 +0000
From: =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jdomingo@internautas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.* hangs just after uncompressing image
Message-ID: <20010916015251.A9478@dardhal.mired.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20010915232738.00a90ba0@mail.tcsitalia.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5.1.0.14.2.20010915232738.00a90ba0@mail.tcsitalia.it>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 15 September 2001, at 23:39:57 +0200,
Johnny Mnemonic wrote:

> 
> Greetings,
> I'm currently running kernel 2.2.19 fine, and I'd need to upgrade to 2.4 
> shortly, but after a careful configuration when i try to boot it hangs just 
> after the message "Ok, booting kernel .."
> 
There has been a similar problem here with an old Pentium 166 over an
equally old mobo and RAM. Some kernels tend to stop the normal boot
process just after displaying "Loading linux........." on the screen.
Sometimes it arrives to the point where even the final "....done." is
printed, but the boot process either halts or reboots.

There is no deterministic pattern for such behavior: for example, 2.2.17
always boots OK. 2.2.18 sometimes fails to boot, rebooting itself when
fails. 2.2.19 nearly always fails to boot, but in this case it halts
instead of rebooting. The same 2.2.19 kernel on a floppy boots a much
higher percentage of times.

With kernels 2.4.x, all I've tried show a similar behavior to that
experienced with 2.2.19. With 2.4.9 even triying to boot from a kernel on
a floppy is hard, because this also fails aprox. 75% of times.

But using 2.4.9-ac10 those booting problems disappear completely: I get
100% success booting from both floppy and the hard drive.

All kernels compiled with the same options turned on, except framebuffer
only present on 2.4.x kernels.

The RAM seems OK (memtest86), as well as the HD (no problems so far),
although I still think is a (crappy or old) hardware issue. But it
happened to be interesting to see that 2.4.9-ac10 booted fine where
vanilla 2.4.9 failed.

-- 
José Luis Domingo López
Linux Registered User #189436     Debian GNU/Linux Potato (P166 64 MB RAM)
 
jdomingo EN internautas PUNTO org  => ¿ Spam ? Atente a las consecuencias
jdomingo AT internautas DOT   org  => Spam at your own risk

