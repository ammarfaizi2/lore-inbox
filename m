Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270069AbTG1VnH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 17:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271069AbTG1VnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 17:43:07 -0400
Received: from CPE-65-29-19-166.mn.rr.com ([65.29.19.166]:1154 "EHLO
	www.enodev.com") by vger.kernel.org with ESMTP id S270069AbTG1VnG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 17:43:06 -0400
Subject: 2.6.0-test2-mm1: Can't mount root
From: Shawn <core@enodev.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059428584.6146.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 28 Jul 2003 16:43:04 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using ide=reverse, and my root is on hde5. 2.6.0-test1-mm2 finds my
root fs fine using the init/do_mounts.c patch posted recently.

2.6.0-test2-mm1 (in which said patch seems to have been included),
however, fails on all of the following root= options:
      * 2105
      * /dev/ide/host2/bus0/target0/lun0/part5
      * /dev/hde5

I don't know what to try next. Can someone enlighten me as to what has
been happening lately?
