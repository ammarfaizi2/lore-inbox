Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290713AbSBTBQF>; Tue, 19 Feb 2002 20:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290715AbSBTBP4>; Tue, 19 Feb 2002 20:15:56 -0500
Received: from ns1.system-techniques.com ([199.33.245.254]:18320 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S290713AbSBTBPg>; Tue, 19 Feb 2002 20:15:36 -0500
Date: Tue, 19 Feb 2002 20:15:31 -0500 (EST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Glover George <dime@gulfsales.com>
cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: st0: Block limits 1 - 16777215 bytes.
In-Reply-To: <000201c1b96e$d8921d00$0300a8c0@yellow>
Message-ID: <Pine.LNX.4.44.0202192005050.32040-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Glover ,  I get the same messages & do not get system
	lock ups .  Might try sending a little bit more info about
	what is going on around any of the lock ups .  If you can
	reliably lock up the system by accessing the tape drive .
	Then send some info to the list about the system & the tape
	drive and how it is attached to the system .  Hth ,  JimL
ps:	All disk & tape drives are scsi .

	Tyan Thunder HE-SL Dual s370 M.B.
 # lspci
00:00.0 Host bridge: Relience Computer CNB20HE (rev 23)
00:00.1 PCI bridge: Relience Computer CNB20HE (rev 01)
00:00.2 Host bridge: Relience Computer: Unknown device 0006 (rev 01)
00:00.3 Host bridge: Relience Computer: Unknown device 0006 (rev 01)
00:01.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR): Unknown device 0021 (rev 01)
00:01.1 SCSI storage controller: Symbios Logic Inc. (formerly NCR): Unknown device 0021 (rev 01)
	BTW these are a Symbios 53c1010 chip on board .
00:02.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 09)
00:04.0 PCI bridge: Intel Corporation 80960RP [i960 RP Microprocessor/Bridge] (rev 05)
00:04.1 RAID bus controller: Mylex Corporation DAC960PX (rev 05)
	Is a DAC960PL
00:07.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
00:0f.0 ISA bridge: Relience Computer: Unknown device 0200 (rev 51)
00:0f.1 IDE interface: Relience Computer: Unknown device 0211
00:0f.2 USB Controller: Relience Computer: Unknown device 0220 (rev 04)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF

 # cat /proc/cpuinfo Below x 2 .

processor       : 0 			( & 1 )
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 849.158
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1690.82


On Tue, 19 Feb 2002, Glover George wrote:

> I've been experiencing mysterious lockups since upgrading to kernel
> 2.4.17.  Looking in the /var/log/messages I hadn't seen anything
> suspicious until now.  I guess the machine hasn't had time to write this
> to disk except every now and then.  The message
>
> Feb 19 11:29:55 butler kernel: st0: Block limits 1 - 16777215 bytes.
>
> I notice this after rebooting after the crash.  So I tried manually
> doing a tar to the tape drive and was able to successfully lock the
> machine up.  Can someone help me understand this and if it is simply a
> limit problem, why would the machine lock up?
>
> Thank you.
>
> Glover George
> Systems/Networks Admin
> Gulf Sales & Supply, Inc.
> (228) 762-0268
> dime@gulfsales.com
> http://www.gulfsales.com
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

