Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265622AbUALRbY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 12:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266238AbUALRbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 12:31:23 -0500
Received: from MailBox.iNES.RO ([80.86.96.21]:46245 "EHLO MailBox.iNES.RO")
	by vger.kernel.org with ESMTP id S265622AbUALRbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 12:31:22 -0500
Subject: Re: [PATCH] Laptop-mode v7 for linux 2.6.1
From: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
To: Bart Samwel <bart@samwel.tk>
Cc: Jan De Luyck <lkml@kcore.org>, linux-kernel@vger.kernel.org,
       Dax Kelson <dax@gurulabs.com>, Kiko Piris <kernel@pirispons.net>,
       Bartek Kania <mrbk@gnarf.org>, Simon Mackinlay <smackinlay@mail.com>
In-Reply-To: <4002A3FC.3000000@samwel.tk>
References: <3FFFD61C.7070706@samwel.tk> <200401121212.44902.lkml@kcore.org>
	 <4002836A.8050908@samwel.tk> <200401121343.34688.lkml@kcore.org>
	 <4002A3FC.3000000@samwel.tk>
Content-Type: text/plain; charset=UTF-8
Organization: iNES Group
Message-Id: <1073928645.1759.30.camel@LNX.iNES.RO>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Mon, 12 Jan 2004 19:30:45 +0200
Content-Transfer-Encoding: 8bit
X-RAVMilter-Version: 8.4.1(snapshot 20020919) (Mailbox)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For the users of laptop-mode patch I find this entry in the manual page
of syslog.conf very interesting:

"You may prefix each entry with the minus ‘‘-’’ sign to omit syncing the
file  after every logging.  Note that you might lose information if the
system crashes right behind a write attempt.  Nevertheless  this  might
give you back some performance, especially if you run programs that use
logging in a very verbose manner."

Found that after finding out that it was syslogd who spun up my disk:)


-- 
Cioby


