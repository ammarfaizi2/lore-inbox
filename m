Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbUDITuq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 15:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbUDITuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 15:50:46 -0400
Received: from aloggw2.analogic.com ([204.178.40.3]:22280 "EHLO
	aloggw2.analogic.com") by vger.kernel.org with ESMTP
	id S261672AbUDITuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 15:50:44 -0400
From: "Richard B. Johnson" <johnson@quark.analogic.com>
Reply-To: "Johnson, Richard" <rjohnson@analogic.com>
To: linux-kernel@vger.kernel.org
Date: Fri, 9 Apr 2004 15:50:56 -0400 (EDT)
Subject: 2.4.24 poll
Message-ID: <Pine.LNX.4.53.0404091547520.32470@quark.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Somebody who read about potential problems with poll() asked
me to pass this on. They had problems sending mail from yahoo.
It seems that couldn't disable something that gets interpreted
by vger as HTML.

>From n26825@yahoo.com Fri Apr  9 15:47:05 2004
To: linux-kernel@vger.kernel.org
From: N26825 <n26825@yahoo.com>
Cc: "Johnson, Richard" <rjohnson@analogic.com>
Subject: Fwd: Linux version 2.4.24 poll


      Subject: Linux version 2.4.24 poll

      Gentlemen:

      In a character device, if I open one with a MINOR number of
      1, variable "minor" in the following driver snippet remains
      0.

      static size_t poll(struct file *fp, struct poll_table_struct
      *wait)
      {
      int minor = MINOR(fp->f_dentry->d_inode->i_rdev);

      If this is a feature, and not a bug, how am I supposed to
      obtain
      the minor number or do I have to use a block device?

      Thanks,

      Gloria

________________________________________________________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway - Enter today

Richard B. Johnson
Project Engineer
Analogic Corporation
Penguin : Linux version 2.2.15 on an i586 machine (330.14 BogoMips).
