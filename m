Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269286AbUJQVei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269286AbUJQVei (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 17:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269289AbUJQVei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 17:34:38 -0400
Received: from main.gmane.org ([80.91.229.2]:6798 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S269286AbUJQVeQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 17:34:16 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Georg Schild <dangertools@gmx.net>
Subject: Weird behaviour of usb printer (drivers/usb/class/usblp.c: usblp0:
 error -110 reading printer status)
Date: Sun, 17 Oct 2004 23:34:12 +0200
Message-ID: <4172E554.1000906@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 83-64-18-125.dynamic.xdsl-line.inode.at
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20040916
X-Accept-Language: en-us, en
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List!

I have some problems with my usb printer with the latest kernelversions. 
Don't know which kernelversion it started but after a while (one or more 
days) the printer connected via usb stops working and this message fills 
up /var/log/messages:

drivers/usb/class/usblp.c: usblp0: error -110 reading printer status

I am using a gentoo-system on an AthlonXP machine. I have tried several 
kernelversions, some with included patchset from gentoo and some vanilla 
kernels. I don't know with which version the problem started, i think 
somewhere at 2.6.8 but this is not exact. To solve the problem i can 
only reboot the machine, switching the printer off and on again is not a 
solution. Other usb-devices still work. Printing system is cups. When 
the messages appear the systemload gets up to something over 50%.

Any suggestions on this problem?


Georg Schild

