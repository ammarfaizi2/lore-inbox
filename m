Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270855AbRH1Mzb>; Tue, 28 Aug 2001 08:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270862AbRH1MzV>; Tue, 28 Aug 2001 08:55:21 -0400
Received: from thunderchild.ikk.sztaki.hu ([193.225.87.24]:49413 "HELO
	thunderchild.ikk.sztaki.hu") by vger.kernel.org with SMTP
	id <S270855AbRH1MzK>; Tue, 28 Aug 2001 08:55:10 -0400
Date: Tue, 28 Aug 2001 14:55:26 +0200
From: Gergely Madarasz <gorgo@thunderchild.debian.net>
To: linux-kernel@vger.kernel.org
Subject: aic7899 problems
Message-ID: <20010828145526.I6202@thunderchild.ikk.sztaki.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the error message is like this:

scsi0:0:3:0: Attempting to queue an ABORT message
scsi0:0:3:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 8194
scsi0:0:3:0: Attempting to queue an ABORT message
scsi0:0:3:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 8194
scsi0:0:3:0: Attempting to queue an ABORT message
(scsi0:A:3:0): Queuing a recovery SCB
scsi0:0:3:0: Device is disconnected, re-queuing SCB
Recovery code sleeping
Recovery code awake
Timer Expired
aic7xxx_abort returns 8195

lots of these messages. the same happens on scsi0:0:4:0, scsi0:0:5:0 and
scsi0:0:9:0, then I get ext2 and I/O errors. I have 4 of these machines
(ibm netfinity 5100), running for several weeks now as http proxies, and
sometimes they crash (3 from 4 have crashed so far at least once, this is
the first time I have logs from the beginning of the crash). The kernel is
stock 2.4.7. On another machine (netfinity 7100, aic7896) I couldn't boot
stock 2.4.9 because I got these messages right after the boot, the old aic
driver worked though. I'm puzzled because the 5100's worked perfectly for
almost a month. What should I try? 

-- 
Madarasz Gergely   gorgo@thunderchild.debian.net   gorgo@linux.rulez.org
    It's practically impossible to look at a penguin and feel angry.
        Egy pingvinre gyakorlatilag lehetetlen haragosan nezni.
                  HuLUG: http://mlf.linux.rulez.org/
