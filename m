Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264937AbRGEMDA>; Thu, 5 Jul 2001 08:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264944AbRGEMCv>; Thu, 5 Jul 2001 08:02:51 -0400
Received: from firewall.fesppr.br ([200.238.157.11]:31478 "EHLO
	smtp2.fesppr.br") by vger.kernel.org with ESMTP id <S264937AbRGEMCo>;
	Thu, 5 Jul 2001 08:02:44 -0400
To: LKML <linux-kernel@vger.kernel.org>
Subject: Random crashes
Message-ID: <994334546.3b44575286329@webmail.fesppr.br>
Date: Thu, 05 Jul 2001 09:02:26 -0300 (BRT)
From: Alexandre Hautequest <hquest@fesppr.br>
Cc: MOSIX maillist <mosix-list@cs.huji.ac.il>,
        Linux SMP ML <linux-smp@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: IMP/PHP IMAP webmail program 2.2.4
X-Originating-IP: 172.18.1.5
X-WebMail-Company: Fundacao de Estudos Sociais do Parana
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all.

I'm using a fresh, new slack8 install, and had follow the MOSIX install steps
(www.mosix.org) over a 2.4.5 kernel. The system runs fine but it randomly
crashes after some time periods, sometimes w/ machine freezes -- i've saw almost
all oops were in kswapd. I don't really know if this can be a MOSIX-related
problem, as a pure kernel (w/o MOSIX) and 2.2 series was acting strange in my
machines (ASUS CUV4X-DLS, 2xP3 933, 512M RAM, 40G+30G IDE disks, 3C905B-TX NIC,
AHA2940 + DAT, onboard SYM53C1010-33 and Intel EPRO100 also enabled).

The kernel config file can be found at
http://www.fesppr.br/~hquest/config-2.4.5-MOSIX.

(Maybe) other interesting info:

ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
Synchronizing Arb IDs.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-5, 2-9, 2-10, 2-11, 2-13, 2-20, 2-21, 2-22, 2-23 not
connected.
..TIMER: vector=49 pin1=2 pin2=0
number of MP IRQ sources: 18.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : IO APIC version: 0011
 WARNING: unexpected IO-APIC, please mail
          to linux-smp@vger.kernel.org
.... register #02: 01000000
.......     : arbitration: 01

(snip)

checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs


Full dmesg in http://www.fesppr.br/~hquest/dmesg-2.4.5.

More info on demand, please cc me as im not subscribed at kernel lists.

TIA.

--
Alexandre Hautequest - hquest at fesppr.br
Fundação de Estudos Sociais do Paraná - http://www.fesppr.br/
Centro de Administração de Redes - CAR
"Eu acreditava no sistema. Até que eles formataram minha família"

Registered Linux User #116289 http://counter.li.org/

"Ninguém é melhor do que todos nós juntos."
Equipe Zeus Competições - www.gincaneiros-zeus.com.br

-------------------------------------------------
Esta mensagem foi enviada pelo WebMail da FESP.
Conheça a FESP: http://www.fesppr.br/
