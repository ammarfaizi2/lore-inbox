Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266223AbUA2Gaq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 01:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266285AbUA2Gaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 01:30:46 -0500
Received: from smtp.dnt.ro ([194.102.255.8]:44433 "EHLO mail.b.astral.ro")
	by vger.kernel.org with ESMTP id S266223AbUA2Gap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 01:30:45 -0500
Subject: ide rescan in kernel 2.6.x
From: Paul Ionescu <paul@acorp.ro>
To: linux-kernel@vger.kernel.org
Message-Id: <1075357820.5703.210.camel@t40>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 29 Jan 2004 08:30:21 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I have an ide-atapi cage for hardisk which is hot swappable (you can
change the pata hdd while the system is running by powering off the
cage, pull it, change drive, insert it again, power on the box).
In kernel 2.4.x I could use hdparm -U before powering off the cage and
hdparm -R after powering on the cage, and the new hdd was recongnized.
With the new 2.6.x kernel, this does not work anymore.
I have searched lkml for a while but I found only pointers for 2.4.x
kernels.

Is ide rescan supported in 2.6.x kernels and how to do it ?

Thanks,
Paul

