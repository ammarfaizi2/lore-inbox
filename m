Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264686AbTAVWln>; Wed, 22 Jan 2003 17:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264690AbTAVWlm>; Wed, 22 Jan 2003 17:41:42 -0500
Received: from magic.adaptec.com ([208.236.45.80]:55544 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S264686AbTAVWlk>; Wed, 22 Jan 2003 17:41:40 -0500
Date: Wed, 22 Jan 2003 15:50:33 -0700
From: "Justin T. Gibbs" <gibbs@btc.adaptec.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Aic7xxx 6.2.28 and Aic79xx 1.3.0 Released
Message-ID: <87730000.1043275833@aslan.btc.adaptec.com>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GNU patch relative to 2.5.59:
 http://people.FreeBSD.org/~gibbs/linux/SRC/aic79xx-linux-2.5.59-20030122-gnupatch.gz

BK send and tarball distributions:
 http://people.FreeBSD.org/~gibbs/linux/SRC/aic79xx-linux-2.4-20030122.bksend.gz
 http://people.FreeBSD.org/~gibbs/linux/SRC/aic79xx-linux-2.5-20030122.bksend.gz
 http://people.FreeBSD.org/~gibbs/linux/SRC/aic79xx-linux-2.4-20030122-tar.gz
 http://people.FreeBSD.org/~gibbs/linux/SRC/aic79xx-linux-2.5-20030122-tar.gz

Driver update diskettes for most distributions:

	http://people.FreeBSD.org/~gibbs/linux/DUD/aic7xxx/
	http://people.FreeBSD.org/~gibbs/linux/DUD/aic79xx/

RPMs for most distributions:

	http://people.FreeBSD.org/~gibbs/linux/RPM/aic7xxx/
	http://people.FreeBSD.org/~gibbs/linux/RPM/aic79xx/

Changes since the driver versions incorperated in 2.5.59:

ChangeSet@1.961, 2003-01-22 15:09:24-07:00, gibbs@overdrive.btc.adaptec.com
  Bump aic79xx driver version number to 1.3.0, now that it has
  passed functional test.

ChangeSet@1.960, 2003-01-22 14:44:51-07:00, gibbs@overdrive.btc.adaptec.com
  Update Aic7xxx and Aic79xx driver documentation.

ChangeSet@1.959, 2003-01-20 16:46:37-07:00, gibbs@overdrive.btc.adaptec.com
  Aic7xxx Driver Update 6.2.28
        o Add some more DV diagnostic code
        o Fix bug that caused sequencer debug code to be
          downloaded always.

  Aic79xx Driver Update 1.3.0.RC2
        o Correct a regression in RC1 that effectively limited DV to just ID 0.
        o Add some more DV diagnostic code
        o Misc code cleanups.

ChangeSet@1.958, 2003-01-17 14:49:42-07:00, gibbs@overdrive.btc.adaptec.com
  Aic7xxx and Aic79xx Driver Update
        Force an SDTR after a rejected WDTR if the syncrate is unkonwn.

ChangeSet@1.957, 2003-01-17 13:20:53-07:00, gibbs@overdrive.btc.adaptec.com
  Bump aic7xxx driver version to 6.2.27.

ChangeSet@1.956, 2003-01-17 13:17:49-07:00, gibbs@overdrive.btc.adaptec.com
  Aic7xxx Driver Update:
    o Determine more conclusively that a BIOS has initialized the
      adapter before using "left over BIOS settings".
    o Adapt to upcoming removal of cmd->target/channel/lun/host in 2.5.X
    o Fix a memory leak on driver unload.
    o Enable the pci_parity command line option and default to pci parity
      error detection *disabled*.  There are just too many broken VIA
      chipsets out there.
    o Move more functionality into aiclib to share with the aic79xx driver.
    o Correct a few negotiation regressions.
    o Don't bother doing full DV on devices that only support async transfers.
      This should fix a few more of the reported problems with DV.

  Aic79xx Driver Update
    o Add abort and bus device reset handlers.
    o Fix a memory leak on driver unload.
    o Adapt to upcoming removal of cmd->target/channel/lun/host in 2.5.X.
    o Correct a few negotiation regressions.

ChangeSet@1.955, 2003-01-17 12:18:22-07:00, gibbs@overdrive.btc.adaptec.com
  Aic79xx Driver Update
        Enable abort and bus device reset handlers for both legacy
        and packetized connections.

ChangeSet@1.954, 2003-01-17 12:10:23-07:00, gibbs@overdrive.btc.adaptec.com
  Aic7xxx and Aic79xx DV Fix:
        Don't bother with DV if the device can only do async


