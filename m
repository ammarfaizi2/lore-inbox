Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275266AbTHAScB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 14:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275267AbTHAScB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 14:32:01 -0400
Received: from imap.gmx.net ([213.165.64.20]:3474 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S275266AbTHASb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 14:31:59 -0400
Date: Fri, 1 Aug 2003 20:20:33 +0200
From: Dominik Brugger <ml.dominik83@gmx.net>
To: Dominik Brugger <ml.dominik83@gmx.net>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: OHCI problems with suspend/resume
Message-Id: <20030801202033.18df44da.ml.dominik83@gmx.net>
In-Reply-To: <20030725095222.21a2632e.ml.dominik83@gmx.net>
References: <20030723220805.GA278@elf.ucw.cz>
	<20030724143731.5fe40b4e.ml.dominik83@gmx.net>
	<20030724224600.GB430@elf.ucw.cz>
	<20030725095222.21a2632e.ml.dominik83@gmx.net>
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

> I will try S4 lateron.

After resuming from S4 uhci_hcd works fine (in opposition to S3 under exactly the same circumstances).
USB support was completely compiled into kernel and not as modules (therefore no unloading before suspend was done).

Interesting:

uhci_hcd wakes up again before power down.

Devices Resumed
Devices Resumed
uhci-hcd 0000:00:11.2: resume
uhci-hcd 0000:00:11.2: can't resume, not suspended!

(now using 2.6.0-test2-mm2)

-Dominik Brugger
