Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287307AbSA1LzW>; Mon, 28 Jan 2002 06:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287149AbSA1LzK>; Mon, 28 Jan 2002 06:55:10 -0500
Received: from port-213-20-228-144.reverse.qdsl-home.de ([213.20.228.144]:61705
	"EHLO drocklinux.dyndns.org") by vger.kernel.org with ESMTP
	id <S287307AbSA1Ly4> convert rfc822-to-8bit; Mon, 28 Jan 2002 06:54:56 -0500
Date: Mon, 28 Jan 2002 12:53:45 +0100 (CET)
Message-Id: <20020128.125345.884013673.rene.rebe@gmx.net>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: alex14641@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: I've stopped the 'Spurious interrupts on IRQ7'
From: Rene Rebe <rene.rebe@gmx.net>
In-Reply-To: <200201280846.g0S8k1E22015@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <20020128083726.83324.qmail@web9205.mail.yahoo.com>
	<200201280846.g0S8k1E22015@Port.imtp.ilyichevsk.odessa.ua>
X-Mailer: Mew version 2.1 on XEmacs 21.4.6 (Common Lisp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: I've stopped the 'Spurious interrupts on IRQ7'
Date: Mon, 28 Jan 2002 10:46:02 -0200

> On 28 January 2002 06:37, Alex Davis wrote:
> > I added the following line to /etc/lilo.conf
> >
> > append = "parport=0x378,7"
> >
> > and re-ran lilo. I also noticed that the 'ERR' field in
> > /proc/interrupts stays at 0, whereas before the mod it
> > was increasing.
> 
> Do you have a printer? Try to boot while it is powered off.
> WHAT is generating irq 7 now?

Hi. As I stated before I get "Spurious interrupts on IRQ7" ony many
(all?) systems (from AMD-K62/Ali, over Pentium-II to AMD-K7-XP/SiS)
with the latest kernels. I started arround 2.4.14/15 ... - None system
has anything attached to the LPT port ...

I'll try to find some time to reboot some to see where it started ...

> It is documented that interrupt controller will report irq 7 if it sees irq 
> but cannot determine what device sends it. That's exactly what's happening 
> when you see "spurious int" message.
> 
> You made kernel believe it's from printer. That does not cure the real 
> problem. BTW, there's not much of a problem, kernel just ignores spurious 
> interrupts. It _is_ a problem if you see 'ERR' number rapidly increasing.
> --
> vda

k33p h4ck1n6
  René

-- 
René Rebe (Registered Linux user: #248718 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://drocklinux.dyndns.org/rene/

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
