Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310470AbSC2Tgv>; Fri, 29 Mar 2002 14:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293461AbSC2Tgl>; Fri, 29 Mar 2002 14:36:41 -0500
Received: from Ptrillia.EUnet.sk ([193.87.242.40]:13696 "EHLO meduna.org")
	by vger.kernel.org with ESMTP id <S293196AbSC2Tgf>;
	Fri, 29 Mar 2002 14:36:35 -0500
From: Stanislav Meduna <stano@meduna.org>
Message-Id: <200203291936.g2TJaWT02200@meduna.org>
Subject: USB printing via ptal broke between 2.4.17 and .18
To: linux-kernel@vger.kernel.org
Date: Fri, 29 Mar 2002 20:36:31 +0100 (CET)
Cc: linux-usb-users@lists.sourceforge.net
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

somewhere between 2.4.17 and 2.4.18 the USB printing to the
HP printer using PTAL library broke. I now get following
in the log:

ptal-init: Starting the HP OfficeJet Linux driver.
ptal-mlcd: SYSLOG at ExMgr.cpp:660, dev=<usb:PSC_750>, pid=1183, errno=111
        ptal-mlcd successfully initialized. 
ptal-printd: ptal-printd(mlc:usb:PSC_750) successfully initialized. 
rc: Starting ptal-init:  succeeded
ptal-mlcd: ERROR at ExMgr.cpp:2445, dev=<usb:PSC_750>, pid=1183, errno=11
        llioService: llioRead returns 3, expected=6! 
ptal-mlcd: ERROR at ExMgr.cpp:853, dev=<usb:PSC_750>, pid=1183, errno=32
        exClose(reason=0x0010) 

Any idea what I should try to further corner the bug?

Red Hat 7.2
2.4.18 kernel
hpoj 0.8
hpijs 1.0
HP PSC 750 multifunctional device
alias usb-controller uhci
no devfs


Regards
-- 
                                      Stano


