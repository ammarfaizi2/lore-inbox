Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280758AbRKYIoC>; Sun, 25 Nov 2001 03:44:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280759AbRKYInu>; Sun, 25 Nov 2001 03:43:50 -0500
Received: from cpe-66-1-134-68.ca.sprintbbd.net ([66.1.134.68]:34252 "HELO
	core.sitedirection.com") by vger.kernel.org with SMTP
	id <S280758AbRKYInk>; Sun, 25 Nov 2001 03:43:40 -0500
Message-ID: <039d01c1758e$51a15d20$0f00a8c0@minniemouse>
From: "Jon" <marsaro@interearth.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <87zo5bgsk6.fsf@toboggan.in.ibm.com>
Subject: Re: eepro100 Driver Problems ( wait
Date: Sun, 25 Nov 2001 00:51:05 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try the Intel module e100, that is the Scyld version.

Regards,

Jon
----- Original Message -----
From: "Sid Carter" <sidcarter@symonds.net>
To: <linux-kernel@vger.kernel.org>
Sent: Sunday, November 25, 2001 12:31 AM
Subject: eepro100 Driver Problems ( wait


> Hi Folks,
>
> I recently got a new comp. It's an IBM PC with an Intel Motherboard.
>
> The results of lspci:
>
> toboggan:~# lspci
> 00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory
Controller Hub (rev 02)
> 00:02.0 VGA compatible controller: Intel Corp. 82815 CGC [Chipset Graphics
Controller] (rev 02)
> 00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (rev 02)
> 00:1f.0 ISA bridge: Intel Corp. 82820 820 (Camino 2) Chipset ISA Bridge
(ICH2) (rev 02)
> 00:1f.1 IDE interface: Intel Corp. 82820 820 (Camino 2) Chipset IDE U100
(rev 02)
> 00:1f.2 USB Controller: Intel Corp. 82820 820 (Camino 2) Chipset USB (Hub
A) (rev 02)
> 00:1f.3 SMBus: Intel Corp. 82820 820 (Camino 2) Chipset SMBus (rev 02)
> 00:1f.5 Multimedia audio controller: Intel Corp. 82820 820 (Camino 2)
Chipset AC'97 Audio Controller (rev 02)
> 01:08.0 Ethernet controller: Intel Corp. 82820 (ICH2) Chipset Ethernet
Controller (rev 01)
>
> I have setup it for network. It is running the Default Linus' 2.4.14
kernel
> tree with the SGI's XFS Patch.
>
> toboggan:~# uname -a
> Linux toboggan 2.4.14-xfs.hommade #1 Sun Nov 11 00:01:40 IST 2001 i686
unknown
>
> Nov 25 13:43:58 toboggan kernel: eepro100: wait_for_cmd_done timeout!
> Nov 25 13:44:13 toboggan last message repeated 5 times
>
> I keep getting the above errors on my machine after which my network
connection
> goes. This keeps happening randomly. I have to do a restart of my network
to get
> on to the network. Anyone knows what the problem ? How I can fix it ?
> Please let me know if you require further information for an analysis of
the
> problem.
>
> Thanks in Advance
> Regards
>         Carter
> --
> The only difference between your girlfriend and a barracuda is the
nailpolish.
>
> Sid Carter                                                   Debian
GNU/Linux.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

