Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264428AbTICXSu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 19:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbTICXSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 19:18:50 -0400
Received: from h002.c000.snv.cp.net ([209.228.32.66]:54473 "HELO
	c000.snv.cp.net") by vger.kernel.org with SMTP id S264428AbTICXSt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 19:18:49 -0400
X-Sent: 3 Sep 2003 23:18:48 GMT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
From: admin@brien.com
Subject: SATA probe delay on boot
X-Sent-From: admin@brien.com
Date: Wed, 03 Sep 2003 19:18:47 -0400 (EDT)
X-Mailer: Web Mail 5.5.0-3_sol28
Message-Id: <20030903161848.2109.h004.c000.wm@mail.brien.com.criticalpath.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a Sil3112A SATA controller, which linux works OK
with. It supports RAID (up to 4 devices), but I'm using
BASE option -- only 1 hard drive.

My question is regarding a 15-20 second delay which
normally occurs every time I boot, unless I pass the
options ide3=0 - ide9=0 to fill up the device table. I
think I have to do this because if I do only ide3=0
(where the device would be), it uses ide4, and so on. I
have GRUB set up to do this automatically, but it's not
exactly adequate (,is it?). So I was wondering if
there're any other ways to get the same affect. Is or
could there be an option to simply disable the probing
of the one specific device/channel every time?

Thanks,

Brien
