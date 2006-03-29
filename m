Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbWC2V0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWC2V0G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 16:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWC2V0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 16:26:06 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41408 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750993AbWC2V0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 16:26:05 -0500
Message-Id: <20060329212129.PS45026300000@infradead.org>
Date: Wed, 29 Mar 2006 18:21:29 -0300
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org
Subject: [PATCH 00/36] V4L/DVB updates
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is available at:
        kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git

Linus, please pull these from master branch.

It contains the following stuff:

+ ad2b2e83c1ee2cd99c4f219a247ea5a4774dbc97 V4L/DVB (3605): Add support for I2C_HW_B_CX2341X board adapter
+ 3d2d03125a51b1a41b045f166e116c1650c6e44c V4L/DVB (3606): Minor layout changes to make it consistent
+ 132132ed45fe6d6e9ef743e4f267286dcb978d95 V4L/DVB (3607): Implement routing command for saa7115.c
+ fb7508c66a72447ece99703df0b04ee38c8238cc V4L/DVB (3608): Implement new routing commands in saa7127.c
+ d213ba3f1fa8f0e84aa65c6768ddc4a055647e20 V4L/DVB (3609): Remove VIDIOC_S_AUDIO from tvaudio: no longer used.
+ 1906bd0cd95b86c7505b131b325327a599838845 V4L/DVB (3610): Added the new routing commands to cx25840.
+ 35d8bd17134fff2c09674a4ad08aa17875a34977 V4L/DVB (3614): Fix compilation warning at powerpc platform
+ 2370c3ff4a7826034f6c9a878c6635815d4deb35 V4L/DVB (3615): Saa7134: select FW_LOADER
+ 2cc16894373aeb5e36c94039ad2469df1ae31906 V4L/DVB (3616a): cpia cleanups
+ 8a0d7045434b50ec2feebff70c03d2a52d640662 V4L/DVB (3616): Bt8xx: select FW_LOADER
+ 408ac0209ff59efb78511048227809809d30627e V4L/DVB (3617): Cxusb: add support for FusionHDTV USB portable remote control
+ 6ff239272987ce06f9e9be4fc0a8a4062d711ac1 V4L/DVB (3619): Whitespace cleanup
+ 9807d4658e0be67668046821025e2d81be9d09c8 V4L/DVB (3620): Fix video-buf PCI wrappers
+ 33e5d100cfd6f386ab925d80322c43f5cd36cecd V4L/DVB (3621): Fix camera key on FusionHDTV portable remote control
+ d344c0dbd79376a8530ff0292b2ca9ec69c1a556 V4L/DVB (3639): Reduce FWSEND due to certain I2C bus adapter limits
+ 9f1ec2c0b878814633bd32ea0672355133ebf4b2 V4L/DVB (3643): Fix default values for tvp5150 controls
+ c9f237602b89ab27c645f2c4ee88a3e717763b2c V4L/DVB (3644): Added PCI IDs of 2 LifeView Cards
+ b94ab321695352ca204c75cde4ed20748d879d58 V4L/DVB (3645): Corrected CVBS input for the AVERMEDIA 777 DVB-T
+ 40bea0f82ef0ddafb866f063ed8a16dd916fe0fa V4L/DVB (3646): Added support for the new Lifeview hybrid cardbus modules
+ b18b08966a2b429a5766a5fe7326fb220662ed70 V4L/DVB (3653a): Kconfig: clean up media/usb menus
+ 2e6873fcced2a368d200713974a0a87319d4480c V4L/DVB (3653b): et61x251: fixed Kconfig menu and Makefile build configuration
+ 29dc49edb5e002b95ef42384e87f46953deb4b92 V4L/DVB (3653c): zc0301: fixed Kconfig menu and Makefile build configuration
+ e540ac33eb1ce7149719dc2a21bf113637473fe8 V4L/DVB (3653d): sn9c102: fixed Kconfig menu and Makefile build configuration
+ 7c42b1838ebe7cdcc53070af5a8eecaec0cf31a1 V4L/DVB (3653e): pwc: fixed Kconfig menu and Makefile build configuration
+ 6fb9830ed58429668edf03f862a1e7816382a891 V4L/DVB (3653f): usbvideo: fixed Kconfig menu and Makefile build configuration
+ 2a5bcaa542786a9dd80fb3cf71094af775b28f33 V4L/DVB (3653g): put v4l encoder/decoder configuration into a separate menu
+ 10216dac24e2955ac723bce01d917c3ab9a1277d V4L/DVB (3655): Support for a new revision of the WT220U-stick
+ 153613022598509594fdd97996519f498ca981dc V4L/DVB (3657): Kconfig: Add firmware download comments for or51211 and or51132
+ 7314d4a5e8ae0ef78821bf70db1b62292728dbcb V4L/DVB (3658): Kconfig: Fix PCI ID typo in VIDEO_CX88_ALSA help text
+ e5f008e3585a51195e0c2bd96ba9595a88ec1551 V4L/DVB (3661): Add wm8739 stereo audio ADC i2c driver
+ d8a252b739877db09431ddd474b4c47d8f4e16e9 V4L/DVB (3662): Don't set msp3400c-non-existent register
+ 6393403b803c3f24d1e9d51aa8460f62812a6570 V4L/DVB (3663): Fix msp3400c wait time and better audio mode fallbacks
+ 4690a5154bd9221ab0a7c6de998d246a16a2d5d9 V4L/DVB (3665): Add new NEC uPD64031A and uPD64083 i2c drivers
+ ad447fe136a4e5363fba59b43d18fcec9c110198 V4L/DVB (3666): Remove trailing newlines
+ 3fc8049590c7db36ff31a4e9de5cb9a0a7fbe7c2 V4L/DVB (3667a): Fix SAP + stereo mode at msp3400
+ 90038f4dd02538e98099375d718f62e6f4759747 V4L/DVB (3667b): cpia2: fix function prototype

Cheers,
Mauro.

V4L/DVB development is hosted at http://linuxtv.org
Development Mercurial trees are available at http://linuxtv.org/hg
---

 Documentation/video4linux/CARDLIST.saa7134     |    5 
 drivers/media/Kconfig                          |   22 -
 drivers/media/dvb/bt8xx/Kconfig                |    1 
 drivers/media/dvb/dvb-usb/cxusb.c              |   64 ++-
 drivers/media/dvb/dvb-usb/dtt200u.c            |   47 ++
 drivers/media/dvb/dvb-usb/dvb-usb-ids.h        |    2 
 drivers/media/dvb/dvb-usb/vp702x-fe.c          |    5 
 drivers/media/dvb/frontends/Kconfig            |   12 
 drivers/media/video/Kconfig                    |  223 ++--------
 drivers/media/video/Makefile                   |    6 
 drivers/media/video/bt8xx/bttv-vbi.c           |    2 
 drivers/media/video/cpia.c                     |   13 
 drivers/media/video/cpia2/cpia2.h              |    2 
 drivers/media/video/cx25840/cx25840-audio.c    |    3 
 drivers/media/video/cx25840/cx25840-core.c     |   24 -
 drivers/media/video/cx25840/cx25840-core.h     |   67 +++
 drivers/media/video/cx25840/cx25840-firmware.c |   15 
 drivers/media/video/cx25840/cx25840-vbi.c      |    3 
 drivers/media/video/cx25840/cx25840.h          |  107 -----
 drivers/media/video/cx88/Kconfig               |    2 
 drivers/media/video/et61x251/Kconfig           |   14 
 drivers/media/video/ir-kbd-i2c.c               |    4 
 drivers/media/video/msp3400-driver.c           |    3 
 drivers/media/video/msp3400-kthreads.c         |   26 -
 drivers/media/video/pwc/Kconfig                |   28 +
 drivers/media/video/saa7115.c                  |   59 ++
 drivers/media/video/saa7127.c                  |   43 --
 drivers/media/video/saa7134/Kconfig            |    1 
 drivers/media/video/saa7134/saa7134-cards.c    |   66 +++
 drivers/media/video/saa7134/saa7134-dvb.c      |    4 
 drivers/media/video/saa7134/saa7134.h          |    1 
 drivers/media/video/sn9c102/Kconfig            |   11 
 drivers/media/video/tuner-core.c               |    2 
 drivers/media/video/tvaudio.c                  |   15 
 drivers/media/video/tveeprom.c                 |    6 
 drivers/media/video/tvp5150.c                  |    8 
 drivers/media/video/upd64031a.c                |  288 +++++++++++++
 drivers/media/video/upd64083.c                 |  262 ++++++++++++
 drivers/media/video/usbvideo/Kconfig           |   39 +
 drivers/media/video/usbvideo/Makefile          |    8 
 drivers/media/video/video-buf.c                |   14 
 drivers/media/video/wm8739.c                   |  355 +++++++++++++++++
 drivers/media/video/zc0301/Kconfig             |   11 
 include/media/cx25840.h                        |   64 +++
 include/media/saa7115.h                        |   37 +
 include/media/saa7127.h                        |   41 +
 include/media/upd64031a.h                      |   42 +-
 include/media/upd64083.h                       |   60 ++
 48 files changed, 1738 insertions(+), 399 deletions(-)

