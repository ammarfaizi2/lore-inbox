Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266848AbSL3Kry>; Mon, 30 Dec 2002 05:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266854AbSL3Kry>; Mon, 30 Dec 2002 05:47:54 -0500
Received: from mailrelay.cs.kuleuven.ac.be ([134.58.40.3]:4023 "EHLO
	hermes.cs.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id <S266848AbSL3Krv>; Mon, 30 Dec 2002 05:47:51 -0500
From: Marko van Dooren <Marko.vanDooren@cs.kuleuven.ac.be>
Reply-To: Marko.vanDooren@cs.kuleuven.ac.be
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Using Philips CDD3610 cd-writer crashes my system with every 2.4 kernel
Date: Mon, 30 Dec 2002 11:55:54 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200212301155.54850.Marko.vanDooren@cs.kuleuven.ac.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

One and a half year ago I asked for help to get the Philips CDD3610 cd-writer 
to work with 2.4 kernels. Peter Kourzanov from Philips contacted me a few 
months after that to tell me how to fix it, and I have since then been 
contacted by other people with the same problem. Apparently my mail is about 
the only reference they can find, so I'll post the fix here to let you (and 
google) know it is fixed.

1) Go to:

http://www.philips.com/pcstuff/

2) click on the green "download" button at the bottom of the site

3) type CDD3610 in the input box that appears, you don't need to select a 
country, and then click search. You need the .exe file, so you need to boot 
either windows or DOS to flash your writer. I think you have to use DOS, but 
I can't remember how I did it.

According to the text file, for the CDD3610 version 3.09 of the firmware is 
included, which is the same version as I used so it should fix the drive.

greetings,


Marko

On Friday 24 August 2001 12:45, Marko van Dooren wrote:
> [1.] Using Philips CDD3610 cd-writer crashes my system with every 2.4
> kernel
>
> [2.] When trying to write a cd with my cd-writer (ide), it tries to write
> for an instant, then my system start getting real slow, and finally only my
> hardware accelerated cursor responds. No problems at all with 2.2 kernels.
> No error messages are in /var/log/messages.
>
> [3.] scsi emulation
>
> [4.] Linux version 2.4.9 (root@marko.kotnet.org) (gcc version 2.95.4
> 20010810 (Debian prerelease)) #2 SMP Thu Aug 23 14:41:04 CEST 2001
>
> [5.]
>
> [6.] Writing a cd
>
> [7.] Debian GNU/Linux unstable and SuSE 7.0
>
> [7.1.] Linux progeny 2.4.9 #2 SMP Thu Aug 23 14:41:04 CEST 2001 i686
> unknown
>
> Gnu C                  2.95.4
> Gnu make               3.79.1
> binutils               2.11.90.0.27
> util-linux             2.11h
> modutils               2.4.7
> e2fsprogs              1.22
> Linux C Library        2.2.4
> Dynamic linker (ldd)   2.2.4
> Procps                 2.0.7
> Net-tools              1.60
> Console-tools          0.2.3
> Sh-utils               2.0.11
> Modules Loaded         sg ide-scsi scsi_mod snd-pcm-oss snd-pcm-plugin
> snd-mixer-oss snd-card-sbawe snd-sb16-csp snd-sb16-dsp snd-pcm snd-mixer
> snd-opl3 snd-hwdep snd-timer snd-mpu401-uart snd-rawmidi snd-seq-device snd
> soundcore parport_pc lp parport ne2k-pci 8390
>
> [7.2.]
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 6
> model name      : Celeron (Mendocino)
> stepping        : 5
> cpu MHz         : 367.511
> cache size      : 128 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov
> pat pse36 mmx fxsr
> bogomips        : 734.00
>
> processor       : 1
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 6
> model name      : Celeron (Mendocino)
> stepping        : 5
> cpu MHz         : 367.511
> cache size      : 128 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov
> pat pse36 mmx fxsr
> bogomips        : 734.00
>
> [7.3.]
> sg                     23488   0 (unused)
> ide-scsi                7776   0
> scsi_mod               54048   2 [sg ide-scsi]
> snd-pcm-oss            18592   0 (unused)
> snd-pcm-plugin         15408   0 [snd-pcm-oss]
> snd-mixer-oss           5088   0 [snd-pcm-oss]
> snd-card-sbawe          5664   0
> snd-sb16-csp           16176   0 [snd-card-sbawe]
> snd-sb16-dsp           17328   0 [snd-card-sbawe snd-sb16-csp]
> snd-pcm                31936   0 [snd-pcm-oss snd-pcm-plugin snd-sb16-dsp]
> snd-mixer              23808   0 [snd-mixer-oss snd-sb16-csp snd-sb16-dsp]
> snd-opl3                5104   0 [snd-card-sbawe]
> snd-hwdep               3376   0 [snd-sb16-csp snd-opl3]
> snd-timer               9296   0 [snd-pcm snd-opl3]
> snd-mpu401-uart         2944   0 [snd-card-sbawe]
> snd-rawmidi            10144   0 [snd-mpu401-uart]
> snd-seq-device          4128   0 [snd-card-sbawe snd-rawmidi]
> snd                    35024   1 [snd-pcm-oss snd-pcm-plugin snd-mixer-oss
> snd-card-sbawe snd-sb16-csp snd-sb16-dsp snd-pcm snd-mixer snd-opl3
> snd-hwdep snd-timer snd-mpu401-uart snd-rawmidi snd-seq-device]
> soundcore               3888   5 [snd]
> parport_pc             14096   1 (autoclean)
> lp                      5360   0 (autoclean)
> parport                25952   1 (autoclean) [parport_pc lp]
> ne2k-pci                5152   1 (autoclean)
> 8390                    6560   0 (autoclean) [ne2k-pci]
>
> [7.4.]
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: E-IDE    Model: CD-ROM 48X/AKU   Rev: U22
>   Type:   CD-ROM                           ANSI SCSI revision: 02
> Host: scsi0 Channel: 00 Id: 01 Lun: 00
>   Vendor: PHILIPS  Model: CDD3610 CD-R/RW  Rev: 3.01
>   Type:   CD-ROM                           ANSI SCSI revision: 02
>
> [7.5.]
>
> [X.] my config:
>
>    <M>    Include IDE/ATAPI CDROM support
>    < >    Include IDE/ATAPI TAPE support
>    < >    Include IDE/ATAPI FLOPPY support
>    <M>    SCSI emulation support
>
>  <M> SCSI support
>     --- SCSI support type (disk, tape, CD-ROM)
>  < > SCSI disk support
>  < > SCSI tape support
>  < > OnStream SC-x0 SCSI tape support
>  <M> SCSI CD-ROM support
>  [ ]   Enable vendor-specific extensions (for SCSI CDROM)
>  <M> SCSI generic support
>  --- Some SCSI devices (e.g. CD jukebox) support multiple LUNs
>  [ ] Probe all LUNs on each SCSI device
>  [ ] Verbose SCSI error reporting (kernel size +=12K)
>  [ ] SCSI logging facility
>
>
> I also tried it with "probe all LUNs on each SCSI device" enabled.
>
>
> Marko No. 5
>
> P.S: I'm not subscribed to this mailing-list, mail me directly for any
> questions.

-- 
Jutil.org - Programming as you know it is over
http://org-jutil.sourceforge.net
