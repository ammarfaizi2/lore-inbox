Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbUCKTbT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 14:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbUCKTbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 14:31:09 -0500
Received: from kiuru.kpnet.fi ([193.184.122.21]:54249 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S261678AbUCKT3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 14:29:55 -0500
Subject: 2.6.4: Mount of /dev/hdb1 impssible
From: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
To: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1079033393.846.5.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Mar 2004 21:29:53 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,
I upgraded from 2.6.4-rc2 to 2.6.4 today, a few minutes before reboot I
noticed that my /dev/hdb1 hadn't been mounted on last reboot, so I tried
to mount it by hand:
# mount /work
mount: /dev/hdb1 already mounted or /work/ busy

Then I thought it'll be fixed when I boot up my 2.6.4, it wasn't, I
tried to mount it to various locations (/mnt/ /mnt/work etc..) and it
didn't want to mount, I'm totally out of ideas with this. according to
df it's not mounted, according to mount it's not mounted and according
to mtab it's not mounted, so what's going on?

It mounts fine on my 2.6.1-mm4 kernel that I use for SCSI burning and
fallback if something fails.

Thanks in advice.

        Markus

