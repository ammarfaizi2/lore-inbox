Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132757AbREIVN5>; Wed, 9 May 2001 17:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132686AbREIVNs>; Wed, 9 May 2001 17:13:48 -0400
Received: from fe040.worldonline.dk ([212.54.64.205]:42508 "HELO
	fe040.worldonline.dk") by vger.kernel.org with SMTP
	id <S132614AbREIVNb>; Wed, 9 May 2001 17:13:31 -0400
Message-ID: <3AF9D0B9.2010406@eisenstein.dk>
Date: Thu, 10 May 2001 01:20:25 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-mosix i586; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en, da
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: MCradiolists: line 2: syntax error near unexpected token
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just unpacked a fresh copy of 2.4.4 and patched it to 2.4.5pre1 and 
ran into a problem. When I attempt to change the type (through 
menuconfig) of CPU to compile for, the following gets dumped to the 
console:


-----[ Start of screendump ]-----

scripts/Menuconfig: CONFIG_M386: command not found
scripts/Menuconfig: ./MCradiolists: line 2: syntax error near unexpected 
token `Pentium-III/Celeron(C'
scripts/Menuconfig: ./MCradiolists: line 2: `   function CONFIG_M386 () 
                 { l_choice 'Processor
family' "386                                    CONFIG_M386      486 
                                 CONFIG_M486    586/K5/5x86/6x86/6x86MX 
                CONFIG_M586      Pentium-Classic 
CONFIG_M586TSC         Pentium-MMX 
CONFIG_M586MMX   Pentium-Pro/Celeron/Pentium-II      CONFIG_M686 
Pentium-III/Celeron(Coppermine)        CONFIG_MPENTIUMIII 
Pentium-4                   CONFIG_MPENTIUM4          K6/K6-II/K6-III 
                      CONFIG_MK6       Athlon/Duron/K7 
CONFIG_MK7        Crusoe                                 CONFIG_MCRUSOE 
   Winchip-C6                          CONFIG_MWINCHIPC6 
Winchip-2                              CONFIG_MWINCHIP2 
Winchip-2A/Winchip-3CONFIG_MWINCHIP3D         CyrixIII/C3 
              CONFIG_MCYRIXIII" Pentium-III/Celeron(Coppermine) ;}'

-----[ End of screendump ]-----

Every other part of menuconfig seems to work well enough, and that's 
probably the reason I've not noticed this before (this is the first time 
I've tried configuring 2.4.5pre1 on a box where I've had to change the 
CPU setting). I hope someone will find this info usefull :-)

If this is just some silly error on my part, then I appologize in 
advance for wasting your time.

Some info about my system:

Thinkpad 600 with heavily patched Slackware Linux 7.1

Output from ver_linux :

Linux jju 2.2.17-mosix #4 Sun Oct 22 21:33:26 CEST 2000 i586 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.10.1.0.4
util-linux             2.11b
mount                  2.11b
modutils               2.4.5
e2fsprogs              1.19
pcmcia-cs              3.1.19
Linux C Library        2.2.2
ldd: version 1.9.9
Procps                 2.0.7
Net-tools              1.52
Kbd                    0.99
Sh-utils               2.0
Modules Loaded         soundcore tulip_cb cb_enabler ds i82365 
pcmcia_core bsd_comp ppp slhc


Best regards,
Jesper Juhl - juhl@eisenstein.dk

