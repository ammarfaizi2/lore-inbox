Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbVBSU7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbVBSU7m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 15:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbVBSU7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 15:59:41 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:3483 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261824AbVBSU7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 15:59:39 -0500
Subject: cfq: depth 4 reached, tagging now on
From: Lee Revell <rlrevell@joe-job.com>
To: axboe@suse.de
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 19 Feb 2005 15:59:07 -0500
Message-Id: <1108846748.10705.31.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Starting around 2.6.11-rc4 I get this printk during the boot process
after kjournald starts, and again if I stress the filesystem.

cfq: depth 4 reached, tagging now on

Is this printk intentional?  I am sure users will wonder about it,
especially because (presumably) cfq turns tagging off at some point in
between, and doesn't say anything about it.

Lee


