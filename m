Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277738AbRKHTww>; Thu, 8 Nov 2001 14:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277758AbRKHTwm>; Thu, 8 Nov 2001 14:52:42 -0500
Received: from [213.96.124.18] ([213.96.124.18]:29931 "HELO dardhal")
	by vger.kernel.org with SMTP id <S277738AbRKHTwf>;
	Thu, 8 Nov 2001 14:52:35 -0500
Date: Thu, 8 Nov 2001 20:52:52 +0000
From: =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jdomingo@internautas.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel booting on serial console ... crawling
Message-ID: <20011108205252.A3018@dardhal.mired.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <9A1957CB9FC45A4FA6F35961093ABB8405445491@srvmail-mtl.ubisoft.qc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9A1957CB9FC45A4FA6F35961093ABB8405445491@srvmail-mtl.ubisoft.qc.ca>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 06 November 2001, at 16:52:18 -0500,
Patrick Allaire wrote:

> 
> I tried to boot my kernel using the serial console, using the
> console=ttyS0,115200 (it does the same thing with 9600) ... it work great
> until :
> [...]
> At this point the output of the serial line slow down dramaticly ... almost
> to a halt ... I get 1 line every 30 seconds !!!
> 
Same problem seems to have happened here with 2.4.14 twice, but booting
as usual (no serial console, just keyboard + monitor).

First time I didn't care much because booted with "mem=8m" to test
system behaviour with little memory, and just when qmail was being
started from the init scripts, the system seemed to halt (not even
ALT-SysRq worked, just printed the action requested to the screen). But
I was no patient enough, and ended up rebooting the machine the hard way.

Today I booted my machine again, and this time during fsck the problem
appeared again: this time was a bit more patient and after several
seconds the boot process continued. ALT-SysRq didn't work until the
system "unfroze". This temporary "halt" happened several times during
the boot sequence, each time lasting a variable amount of seconds.

It's been 2 hours since that happened, and the machine is working
nicely so far.

Kernel configuration is the same as it was on, among others, 2.4.10,
2.4.12 and 2.4.13, but this problem only have showed with 2.4.14.

-- 
José Luis Domingo López
Linux Registered User #189436     Debian Linux Woody (P166 64 MB RAM)
 
jdomingo EN internautas PUNTO org  => ¿ Spam ? Atente a las consecuencias
jdomingo AT internautas DOT   org  => Spam at your own risk

