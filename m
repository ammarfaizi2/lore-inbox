Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264507AbTFITWU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 15:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264523AbTFITWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 15:22:19 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:3981 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264507AbTFITWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 15:22:18 -0400
Date: Mon, 9 Jun 2003 20:35:55 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: ext3 / reiserfs data corruption, 2.5-bk
Message-ID: <20030609193541.GA21106@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5 Bitkeeper tree as of last 24 hrs. Running a lot
of disk IO stress (multiple fsstress, over 100 fsx instances,
and random sync calling) produced failures on both reiserfs
and ext3.

Tests were done on seperate disks, but concurrently.

fsx logs at
http://www.codemonkey.org.uk/cruft/reiserfs.fsxlog
http://www.codemonkey.org.uk/cruft/ext3.fsxlog

		Dave

