Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280819AbRKGPU5>; Wed, 7 Nov 2001 10:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280817AbRKGPUi>; Wed, 7 Nov 2001 10:20:38 -0500
Received: from uunet-gw.macroscoop.nl ([195.193.201.73]:8453 "EHLO
	mondriaan.macroscoop.nl") by vger.kernel.org with ESMTP
	id <S280816AbRKGPUf>; Wed, 7 Nov 2001 10:20:35 -0500
From: Pim Zandbergen <P.Zandbergen@macroscoop.nl>
To: linux-kernel@vger.kernel.org, "Justin T. Gibbs" <gibbs@scsiguy.com>,
        Pim Zandbergen <P.Zandbergen@macroscoop.nl>
Newsgroups: comp.os.linux.hardware
Subject: aic7xxx freezes with kernel 2.4.13
Date: Wed, 07 Nov 2001 16:20:17 +0100
Organization: Macroscoop BV
Message-ID: <c8iiutoqe1grq0hr0h1htt5gnpbnh3k91f@4ax.com>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got a Dell PowerEdge 1300 with dual PIII's and dual aic7xxx
controllers. One controller is onboard, the other is in a PCI slot.

The system is running Red Hat 7.1 with kernel 2.4.13.

Lately, this system is experiencing freezes that may last one or two
minutes. These usually occur during heavy Samba activity. After the
freeze, the system usually recovers, but by then, the Samba clients
have timed out their operations.

Syslog shows the freezes are related to the SCSI subsystem. I'm having
trouble interpreting this information. Is my hardware suspect or could
this be a driver bug?

Syslog entries (with aic7xxx=verbose) showing the boot process and a
system freeze can be found on

http://www.macroscoop.nl/~pim/aic7xxx/syslog.html (98.080 bytes) or
http://www.macroscoop.nl/~pim/aic7xxx/syslog.gz   (6.410 bytes)

Thanks,
Pim
