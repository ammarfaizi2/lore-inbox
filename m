Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314740AbSD2Bzr>; Sun, 28 Apr 2002 21:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314743AbSD2Bzq>; Sun, 28 Apr 2002 21:55:46 -0400
Received: from polywog.navpoint.com ([207.106.42.251]:6528 "EHLO
	polywog.navpoint.com") by vger.kernel.org with ESMTP
	id <S314740AbSD2Bzn>; Sun, 28 Apr 2002 21:55:43 -0400
Message-ID: <3CCCA9A0.70807@navpoint.com>
Date: Sun, 28 Apr 2002 22:02:08 -0400
From: Emilio Recio <polywog@navpoint.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020310
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Henning Schroeder <hgs@anna-strasse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: VT8367 [KT266] and high IDE load crashes
In-Reply-To: <19984436483.20020428183713@anna-strasse.de>
Content-Type: multipart/mixed;
 boundary="------------090202040106020207010704"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090202040106020207010704
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Henning Schroeder wrote:
> Hello,
> 
> I have an ASUS A7V266-E Mainboard (VT8367 [KT266] Chipset, with VIA
> IDE and Promise 20265 IDE Controller on board) that keeps crashing
> under high IDE load. Athlon XP2000+ cpu, 1.5GiB DDR-RAM.

This is the same problem that I have attempted to report with regards to the 
Athlon processors. It's especially nasty when you mix scsi modules + the ide 
stuff. I hard compiled everything into the kernel before, but I still have 
problems.

Just now my computer crashed when I was attempting to mount my floppy drive. 
In fact, it crashes all the time (when in X) when I attempt to mount my floppy 
drive during or after high IDE activity.


See attached messages for more information.

-Elmo




--------------090202040106020207010704
Content-Type: message/rfc822;
 name="imap-message://erecio@polywog.navpoint.com/MailingLists/linux-kernel#966"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="imap-message://erecio@polywog.navpoint.com/MailingLists/linux-kernel#966"

Return-Path: <linux-kernel-owner+polywog=40navpoint.com@vger.kernel.org>
Received: from localhost (localhost [127.0.0.1])
	by polywog.navpoint.com (8.11.2/8.11.2/SuSE Linux 8.11.1-0.5) with ESMTP id g3KHUIF28584
	for <erecio@localhost>; Sat, 20 Apr 2002 13:30:18 -0400
Received: from west.navpoint.com [207.106.42.13]
	by localhost with POP3 (fetchmail-5.8.0)
	for erecio@localhost (single-drop); Sat, 20 Apr 2002 13:30:18 -0400 (EDT)
Received: from vger.kernel.org (vger.kernel.org [209.116.70.75])
	by west.navpoint.com (8.11.6/8.10.1) with ESMTP id g3KHJ1Y14794
	for <polywog@navpoint.com>; Sat, 20 Apr 2002 13:19:01 -0400 (EDT)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312928AbSDTRPl>; Sat, 20 Apr 2002 13:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312970AbSDTRPk>; Sat, 20 Apr 2002 13:15:40 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:34764 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S312928AbSDTRPi>;
	Sat, 20 Apr 2002 13:15:38 -0400
Received: (qmail 2024 invoked by uid 0); 20 Apr 2002 17:15:32 -0000
Received: from c-18-89.cvx-hh.dial.de.ignite.net (HELO gmx.net) (62.134.89.18)
  by mail.gmx.net (mp009-rz3) with SMTP; 20 Apr 2002 17:15:32 -0000
Message-ID: <3CC1A228.2B9C72F6@gmx.net>
Date: Sat, 20 Apr 2002 19:15:20 +0200
From: Richard Ems <r.ems.home@gmx.net>
Reply-To: r.ems@gmx.net
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en,de,es
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
Subject: Re: AMD Athlon + VIA Crashing On Disk I/O
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre, hi list!

I'm also having random lockups with an ASUS A7V266-E Mainboard, Athlon
XP 1800+.
Chipset is the VIA KT266A, kernel 2.4.18 (SuSE version 2.4.18-58, from
SuSE 8.0).
Nothing in the logs.

Andre, could you verify your possible answer? Any results?

Thanks, Richard

Andre Hedrick wrote:
>Hi Josh,
>
>I think I have an answer why the crash but I need to verify with a
client
>as we are seeing the same problem on various VIA boards.  The good new
is
>we found on board that does not do this nasty.  So we are doing a
>component wide comparisong of settings.
>
>It is a really cool and smart embedded server found at
>
 >       http://www.nit.ca/
>
>Cheers,
>
>Andre Hedrick
>LAD Storage Consulting Group



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

--------------090202040106020207010704
Content-Type: message/rfc822;
 name="imap-message://erecio@polywog.navpoint.com/MailingLists/linux-kernel#213"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="imap-message://erecio@polywog.navpoint.com/MailingLists/linux-kernel#213"

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from localhost (localhost [127.0.0.1])
	by polywog.navpoint.com (8.11.2/8.11.2/SuSE Linux 8.11.1-0.5) with ESMTP id g3H405F04431
	for <erecio@localhost>; Wed, 17 Apr 2002 00:00:05 -0400
Received: from west.navpoint.com [207.106.42.13]
	by localhost with POP3 (fetchmail-5.8.0)
	for erecio@localhost (single-drop); Wed, 17 Apr 2002 00:00:05 -0400 (EDT)
Received: from vger.kernel.org (vger.kernel.org [209.116.70.75])
	by west.navpoint.com (8.11.6/8.10.1) with ESMTP id g3H3o1s17069
	for <polywog@navpoint.com>; Tue, 16 Apr 2002 23:50:01 -0400 (EDT)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314042AbSDQDs3>; Tue, 16 Apr 2002 23:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314043AbSDQDs2>; Tue, 16 Apr 2002 23:48:28 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:56582
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S314042AbSDQDs2>; Tue, 16 Apr 2002 23:48:28 -0400
Received: from localhost (andre@localhost)
	by master.linux-ide.org (8.9.3/8.9.3) with ESMTP id UAA11490;
	Tue, 16 Apr 2002 20:47:49 -0700
Date: Tue, 16 Apr 2002 20:47:49 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Josh McKinney <forming@comcast.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: AMD Athlon + VIA Crashing On Disk I/O
In-Reply-To: <20020417015525.GA3118@cy599856-a>
Message-ID: <Pine.LNX.4.10.10204162039350.11230-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Josh,

I think I have an answer why the crash but I need to verify with a client
as we are seeing the same problem on various VIA boards.  The good new is
we found on board that does not do this nasty.  So we are doing a
component wide comparisong of settings.

It is a really cool and smart embedded server found at

	http://www.nit.ca/

Cheers,

Andre Hedrick
LAD Storage Consulting Group


On Tue, 16 Apr 2002, Josh McKinney wrote:

> On approximately Tue, Apr 16, 2002 at 09:45:43PM -0200, Denis Vlasenko wrote:
> > >
> > > I get (when FSCK):
> > >
> > > spurious 8259A IRQ7
> > 
> > cat /proc/interrupts, is ther lots of ERR: interrupts?
> > 
> 
> I also get the spurious 8259A messages upon booting my Soyo Dragon+ board, KT266A chipset.
> Here is the output of /proc/interrupts:
> 
>          CPU0
>   0:    1146449          XT-PIC  timer
>   1:       1258          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   8:          1          XT-PIC  rtc
>  10:      10584          XT-PIC  eth0
>  11:          0          XT-PIC  es1370
>  12:         20          XT-PIC  PS/2 Mouse
>  14:         17          XT-PIC  ide0
>  15:      15193          XT-PIC  ide1
> NMI:          0
> LOC:    1146346
> ERR:         78
> MIS:          0
> 
> I am just curious as to what this means, I haven't seen any real problems with the board,
> except for everything wanting to go to IRQ 11, but that isn't a kernel issue.
> 
> Josh
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

--------------090202040106020207010704
Content-Type: message/rfc822;
 name="imap-message://erecio@polywog.navpoint.com/MailingLists/linux-kernel#210"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="imap-message://erecio@polywog.navpoint.com/MailingLists/linux-kernel#210"

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from localhost (localhost [127.0.0.1])
	by polywog.navpoint.com (8.11.2/8.11.2/SuSE Linux 8.11.1-0.5) with ESMTP id g3H3U4F04335
	for <erecio@localhost>; Tue, 16 Apr 2002 23:30:04 -0400
Received: from west.navpoint.com [207.106.42.13]
	by localhost with POP3 (fetchmail-5.8.0)
	for erecio@localhost (single-drop); Tue, 16 Apr 2002 23:30:04 -0400 (EDT)
Received: from vger.kernel.org (vger.kernel.org [209.116.70.75])
	by west.navpoint.com (8.11.6/8.10.1) with ESMTP id g3H3GAs10454
	for <polywog@navpoint.com>; Tue, 16 Apr 2002 23:16:10 -0400 (EDT)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314035AbSDQDON>; Tue, 16 Apr 2002 23:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314037AbSDQDOM>; Tue, 16 Apr 2002 23:14:12 -0400
Received: from 216-55-134-41.dsl.san-diego.abac.net ([216.55.134.41]:11743
	"EHLO mail") by vger.kernel.org with ESMTP id <S314035AbSDQDOM>;
	Tue, 16 Apr 2002 23:14:12 -0400
Received: from navpoint.com (polywog.navpoint.com [207.106.42.251])
	by mail (Postfix on RHEmS (RedHat)) with ESMTP
	id B8538A3BBB; Tue, 16 Apr 2002 22:13:44 -0400 (EDT)
Message-ID: <3CBCE87A.2080905@navpoint.com>
Date: Tue, 16 Apr 2002 23:14:02 -0400
From: Emilio Recio <polywog@navpoint.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Eriksson <nitrax@giron.wox.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AMD Athlon + VIA Crashing On Disk I/O
In-Reply-To: <Pine.LNX.4.33.0204160921060.472-100000@polywog.navpoint.com> <00dc01c1e58b$668dd2f0$0201a8c0@homer>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Eriksson wrote:

>First check out what kind of chipset you really have;
>lspci -xs 0:0
>should do the thing. Post the results.
>
>In the meantime, you can try to compile for
>"Pentium-Pro/Celeron/Pentium-II", and check your BIOS settings one more time
>(set stuff to "safe" values). Also, do you have a really recent kernel, such
>as 2.4.18? There were some changes in the Athlon/VIA "quirks" department a
>while ago, but after 2.4.15 (i think).
>

I think I tried the pentium stuff, but that would freeze up the computer 
too (the HD light comes on, and nothing else works, not even ping(!)) 
But I think that was for a <=2.4.14. I should try it again.

Here's the output of lspci:

polywog:~ # lspci -xs 0:0
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] 
(rev 03)
00: 06 11 05 03 06 00 10 22 03 00 00 06 00 08 00 00
10: 08 00 00 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

polywog:~ # lspci -xs 0:7.1
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00: 06 11 71 05 07 00 90 02 06 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 c0 00 00 00 00 00 00 00 00 00 00 06 11 71 05
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 00 00 00

New news, I got up this morning and the computer was frozen again. This 
time, I compiled in the kernel (not as modules) SCSI, SCSI CD, SCSI 
Disk, PPA, completely removed ide-scsi stuff, compiled in ide-cdrom. So 
I took ide-scsi out of the loop altogether.

polywog:~ # cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1199.714
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov
pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2392.06

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

--------------090202040106020207010704--

