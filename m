Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264957AbTFCLKP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 07:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264958AbTFCLKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 07:10:15 -0400
Received: from HDOfa-01p4-228.ppp11.odn.ad.jp ([61.116.133.228]:21177 "HELO
	hokkemirin.dyndns.org") by vger.kernel.org with SMTP
	id S264957AbTFCLKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 07:10:14 -0400
Date: Tue, 03 Jun 2003 20:23:36 +0900 (JST)
Message-Id: <20030603.202336.74738231.whatisthis@jcom.home.ne.jp>
To: linux-kernel@vger.kernel.org
Subject: [tulip] Stopping when tx > 2GB w/ ADMtek AN983B
From: Kyuma Ohta <whatisthis@jcom.home.ne.jp>
X-Mailer: Mew version 4.0.52 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm using 2.4.21-rc6 with MSI MS-6378 rev3 mainboard and DURON.
When transmitting packets to on-board-ether-chip ADMtek AN938B over 2GB,
communication with other terminal via ethrnet  was stopped :-(
And,I ifconfig eth0 down and ifconfig eth0 up to reset ether,communication 
was restarted.

On board controller (ADMtek) displayed by lspci is below:
>00:0f.0 Ethernet controller: Linksys: Unknown device 9511 (rev 11)

Please....
Ohta

