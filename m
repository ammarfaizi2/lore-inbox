Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752901AbWKCCHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901AbWKCCHJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 21:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752938AbWKCCHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 21:07:09 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:55050 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752901AbWKCCHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 21:07:06 -0500
Date: Fri, 3 Nov 2006 03:07:06 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.16.30
Message-ID: <20061103020706.GC13381@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Security fixes since 2.6.16.29:
- CVE-2006-3741: IA64: file descriptor reference counting in perfmon
- CVE-2006-4623: DVB: Proper handling ULE SNDU length of 0
- CVE-2006-4997: ATM CLIP: Do not refer freed skbuff in clip_mkip()


Location:
ftp://ftp.kernel.org/pub/linux/kernel/v2.6/

git tree:
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git

RSS feed of the git tree:
http://www.kernel.org/git/?p=linux/kernel/git/stable/linux-2.6.16.y.git;a=rss


Changes since 2.6.16.29:

Adrian Bunk (5):
      V4L/DVB: Saa7134: document that there's also a 220RF from KWorld
      add drivers/media/video/saa7134/saa7134-input.c:flydvb_codes
      Linux 2.6.16.30-pre1
      Linux 2.6.16.30-rc1
      Linux 2.6.16.30

Andrew Burri (1):
      V4L/DVB: Add support for Kworld ATSC110

Andrew de Quincey (2):
      v4l/dvb: Fix budget-av frontend detection
      v4l/dvb: Backport fix to artec USB DVB devices

Ang Way Chuang (1):
      dvb-core: Proper handling ULE SNDU length of 0 (CVE-2006-4623)

Curt Meyers (3):
      V4L/DVB: KWorld ATSC110: implement set_pll_input
      V4L/DVB: Kworld ATSC110: enable composite and svideo inputs
      V4L/DVB: Kworld ATSC110: initialize the tuner for analog mode on module load

David S. Miller (2):
      [SPARC64]: Fix sched_clock() wrapping every ~17 seconds.
      [SPARC64]: Kill bogus check from bootmem_init().

Giampiero Giancipoli (1):
      V4L/DVB: Added support for the LifeView FlyDVB-T LR301 card

Hartmut Hackmann (6):
      V4L/DVB: Added support for the ADS Instant TV DUO Cardbus PTV331
      V4L/DVB: Added PCI IDs of 2 LifeView Cards
      V4L/DVB: Corrected CVBS input for the AVERMEDIA 777 DVB-T
      V4L/DVB: Added support for the new Lifeview hybrid cardbus modules
      V4L/DVB: TDA10046 Driver update
      V4L/DVB: TDA8290 update

Peter Hartshorn (1):
      V4L/DVB: Added support for the Tevion DVB-T 220RF card

Henk Vergonet (2):
      USB: Fix unload oops and memory leak in yealink driver
      USB: add YEALINK phones to the HID_QUIRK_IGNORE blacklist

Jay Cliburn (1):
      via-velocity: fix speed and link status reported by ethtool

Jose Alberto Reguero (1):
      V4L/DVB: Add support for the Avermedia 777 DVB-T card

Julien Tous (1):
      [AGPGART] ATI RS350 support.

Kim Nordlund (1):
      PKT_SCHED: cls_basic: Use unsigned int when generating handle

Kirill Korotaev (1):
      fix fdset leakage

Magnus Kessler (1):
      [AGPGART] VIA PT880 Ultra support.

Mark M. Hoffman (1):
      I2C: fix 'ignore' module parameter handling

Martin Schwidefsky (1):
      kernel/kmod.c: fix a race condition in usermodehelper.

maximilian attems (1):
      V4L/DVB: Saa7134: select FW_LOADER

Michael Krufky (3):
      V4L/DVB: Kworld ATSC110: cleanups
      V4L/DVB: Saa7134: make unsupported secondary decoder message generic
      V4L/DVB: Medion 7134: Autodetect second bridge chip

Michael Rash (1):
      [TEXTSEARCH]: Fix Boyer Moore initialization bug

Michal Ostrowski (1):
      [PPPOE]: Advertise PPPoE MTU

Olaf Hering (1):
      fbdev: add modeline for 1680x1050@60

Oliver Endriss (1):
      v4l/dvb: Backport the budget driver DISEQC instability fix

Rafael J. Wysocki (1):
      [CIFS] Allow cifsd to suspend if connection is lost

Rickard Osser (1):
      V4L/DVB: Saa7134: add support for AVerMedia A169 Dual Analog tuner card

Roland Dreier (1):
      Convert idr's internal locking to _irqsave variant

Roy Marples (1):
      via-velocity: the link is not correctly detected when the device starts

Stephane Eranian (1):
      [IA64] correct file descriptor reference counting in perfmon (CVE-2006-3741)

Stephen Hemminger (3):
      sky2: use dev_alloc_skb for receive buffers
      sky2: fix fiber support
      sky2: accept flow control

Steve French (3):
      [CIFS] fs/cifs/dir.c: fix possible NULL dereference
      [CIFS] Fix unlink oops when indirectly called in rename error path under heavy stress.
      [CIFS] Fix typo in earlier cifs_unlink change and protect one extra path.

TAMUKI Shoichi (2):
      V4L/DVB: Add saa713x card: ELSA EX-VISION 700TV (saa7130)
      V4L/DVB: ELSA EX-VISION 700TV: fix incorrect PCI subsystem ID

Tushar Gohad (1):
      PFKEYV2: Fix inconsistent typing in struct sadb_x_kmprivate.

YOSHIFUJI Hideaki (2):
      IPV6: Sum real space for RTAs.
      [ATM] CLIP: Do not refer freed skbuff in clip_mkip() (CVE-2006-4997)


 Documentation/dvb/get_dvb_firmware          |   23 +
 Documentation/video4linux/CARDLIST.saa7134  |   12 
 Makefile                                    |    2 
 arch/ia64/kernel/perfmon.c                  |    4 
 arch/sparc64/kernel/time.c                  |    2 
 arch/sparc64/mm/init.c                      |    3 
 drivers/char/agp/ati-agp.c                  |    4 
 drivers/char/agp/via-agp.c                  |    7 
 drivers/i2c/i2c-core.c                      |    4 
 drivers/media/dvb/dvb-core/dvb_net.c        |    3 
 drivers/media/dvb/frontends/dvb-pll.c       |   52 ++-
 drivers/media/dvb/frontends/dvb-pll.h       |    1 
 drivers/media/dvb/frontends/tda1004x.c      |   25 +
 drivers/media/dvb/frontends/tda1004x.h      |    3 
 drivers/media/dvb/ttpci/budget-av.c         |    5 
 drivers/media/dvb/ttpci/budget.c            |    6 
 drivers/media/video/saa7134/Kconfig         |    1 
 drivers/media/video/saa7134/saa7134-cards.c |  337 +++++++++++++++++++-
 drivers/media/video/saa7134/saa7134-dvb.c   |  147 ++++++++
 drivers/media/video/saa7134/saa7134-input.c |   43 ++
 drivers/media/video/saa7134/saa7134.h       |   10 
 drivers/media/video/tda8290.c               |    6 
 drivers/net/pppoe.c                         |    1 
 drivers/net/sky2.c                          |   87 +++--
 drivers/net/sky2.h                          |   17 -
 drivers/net/via-velocity.c                  |   23 +
 drivers/usb/input/hid-core.c                |    4 
 drivers/usb/input/yealink.c                 |   12 
 drivers/video/modedb.c                      |    4 
 fs/cifs/connect.c                           |    1 
 fs/cifs/dir.c                               |    3 
 fs/cifs/inode.c                             |   15 
 fs/file.c                                   |    4 
 include/linux/pci_ids.h                     |    1 
 include/linux/pfkeyv2.h                     |    2 
 kernel/kmod.c                               |    5 
 lib/idr.c                                   |   16 
 lib/ts_bm.c                                 |   11 
 net/atm/clip.c                              |    2 
 net/ipv6/addrconf.c                         |   28 +
 net/sched/cls_basic.c                       |    2 
 41 files changed, 831 insertions(+), 107 deletions(-)
