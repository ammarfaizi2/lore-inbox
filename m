Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261678AbSJUUwX>; Mon, 21 Oct 2002 16:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261679AbSJUUwX>; Mon, 21 Oct 2002 16:52:23 -0400
Received: from ulima.unil.ch ([130.223.144.143]:3200 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S261678AbSJUUwW>;
	Mon, 21 Oct 2002 16:52:22 -0400
Date: Mon, 21 Oct 2002 22:58:29 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.5.44 don't allow ZIP ejection :-((
Message-ID: <20021021205829.GA6665@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

in 2.5.n n<44 the eject command didn't work anymore, but I could
manually eject my disc...

With 2.5.44 the eject command still don't work, but even worse: I should
reboot to eject the device:

Oct 21 16:55:57 ulima kernel:  /dev/ide/host0/bus1/target1/lun0: unknown partition tableOct 21 16:55:57 ulima kernel: ide-floppy: unsupported command in queue: dev 16:40: REQ_NOMERGE REQ_STARTED REQ_BLOCK_PC sector 65680, nr/cnr 8/8
Oct 21 16:55:57 ulima kernel: bio 00000000, biotail 00000000
Oct 21 16:55:57 ulima kernel: end_request: I/O error, dev 16:40, sector 65680

Thank you,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
