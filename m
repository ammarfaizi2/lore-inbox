Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263241AbTJZQLL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 11:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263258AbTJZQLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 11:11:11 -0500
Received: from 168.227-200-80.adsl.skynet.be ([80.200.227.168]:11528 "EHLO
	gw.ici") by vger.kernel.org with ESMTP id S263241AbTJZQLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 11:11:06 -0500
Message-ID: <3F9BF218.2050104@trollprod.org>
Date: Sun, 26 Oct 2003 17:11:04 +0100
From: Olivier NICOLAS <olivn@trollprod.org>
Organization: TrollPod
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031009
X-Accept-Language: fr, en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test9: suspend success 
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hardware: Compaq Armada E500

 From X : sleep 1; echo 4 > /proc/acpi/sleep

Loglevel set to 8
Stopping tasks: =================================|
Freeing memory: ..................|
hdb: start_power_step(step: 0)
hdb: completing PM request, suspend
hda: start_power_step(step: 0)
hda: completing PM request, suspend
/critical section: Counting pages to copy[nosave c03c4000] (pages 
needed: 3431+5              12=3943 free: 29320)
Alloc pagedir
[nosave c03c4000]<4>Freeing prev allocated pagedir
hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
blk: queue c7ee1000, I/O limit 4095Mb (mask 0xffffffff)
hda: completing PM request, resume
hdb: Wakeup request inited, waiting for !BSY...
hdb: start_power_step(step: 1000)
hdb: completing PM request, resume
Fixing swap signatures... ok
Restarting tasks... done
e100: eth0 NIC Link is Up 100 Mbps Full duplex


lsmod
Module                  Size  Used by
snd_mixer_oss          17120  1
snd_seq_midi            6592  0
snd_seq_midi_event      6240  1 snd_seq_midi
snd_seq                53360  2 snd_seq_midi,snd_seq_midi_event
snd_es1968             28868  1
snd_ac97_codec         52484  1 snd_es1968
snd_pcm                88932  1 snd_es1968
snd_page_alloc          9092  2 snd_es1968,snd_pcm
snd_timer              21988  2 snd_seq,snd_pcm
snd_mpu401_uart         6080  1 snd_es1968
snd_rawmidi            20640  2 snd_seq_midi,snd_mpu401_uart
snd_seq_device          6440  3 snd_seq_midi,snd_seq,snd_rawmidi
snd                    43972  11 
snd_mixer_oss,snd_seq_midi,snd_seq_midi_event,snd_seq,snd_es1968,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore               7008  2 snd
ntfs                   87788  2


lspci
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge 
(rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge 
(rev 03)
00:04.0 CardBus bridge: Texas Instruments PCI1225 (rev 01)
00:04.1 CardBus bridge: Texas Instruments PCI1225 (rev 01)
00:07.0 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
00:08.0 Multimedia audio controller: ESS Technology ES1978 Maestro 2E 
(rev 10)
00:09.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] 
(rev 09)
00:09.1 Serial controller: Lucent Microelectronics LT WinModem
01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility 
P/M AGP 2x (rev 64)


Olivier




