Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266006AbUBJRAB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 12:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266022AbUBJQ7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 11:59:46 -0500
Received: from proxy.ch.cybtec.net ([217.117.162.97]:7940 "EHLO
	proxy.ch.cybtec.net") by vger.kernel.org with ESMTP id S266006AbUBJQ5x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 11:57:53 -0500
Subject: 2.6.3-rc vs 2.6.2: new problem at boot?
From: =?ISO-8859-1?Q?Jo=EBl?= Bourquard <numlock@freesurf.ch>
Reply-To: numlock@freesurf.ch
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Message-Id: <1076432269.7026.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 10 Feb 2004 17:57:50 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry if this were reported already, but I think this might have
been overlooked, and is important for upcoming 2.6.3.

I'm booting 2.6.2 fine, but with the exact same .config file,
2.6.3-rc1/2 finds no volume groups during initrd execution.

/boot is on /dev/hda1:reiserfs, everything else is on /dev/hda2:LVM.

Before I add debug stuff to initrd, was there a voluntary change
somewhere between 2.6.2 and 2.6.3-rc1 that can trigger this ?

Thanks
Joël

