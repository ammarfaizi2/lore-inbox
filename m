Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289874AbSAKE6q>; Thu, 10 Jan 2002 23:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289875AbSAKE6g>; Thu, 10 Jan 2002 23:58:36 -0500
Received: from adsl-157-194-17.dab.bellsouth.net ([66.157.194.17]:32902 "EHLO
	midgaard.darktech.org") by vger.kernel.org with ESMTP
	id <S289874AbSAKE6d>; Thu, 10 Jan 2002 23:58:33 -0500
Date: Fri, 11 Jan 2002 00:00:52 -0500
From: Andreas Boman <aboman@goofy.nerdfest.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.17 has 2 modules named sym53c8xx.o
Message-Id: <20020111000052.34204997.aboman@goofy.nerdfest.org>
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i386-nerdfest-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It seems a new sym53c8xx was added in 2.4.17, and now there are 2 modules,
both named sym53c8xx.o (CONFIG_SCSI_SYM53C8XX and
CONFIG_SCSI_SYM53C8XX_2). This was noticed since my mkinitrd script isn't
smart enough to destinguish the two. Leading to the question how does
modprobe? Comparing this with the naming scheme used for the two aic7xxx
modules (aic7xxx.o and aic7xxx_old.o) it seems like its a bug to me, in
either case I'd appritiate some input from somebody clued in on the issue.


Thanks,
	Andreas
