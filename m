Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbTDCRAW 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 12:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S261373AbTDCRAW 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 12:00:22 -0500
Received: from host145.south.iit.edu ([216.47.130.145]:42136 "EHLO
	found.lostlogicx.com") by vger.kernel.org with ESMTP
	id S261369AbTDCRAW 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 12:00:22 -0500
Date: Thu, 3 Apr 2003 11:11:48 -0600
From: Brandon Low <lostlogic@gentoo.org>
To: linux-kernel@vger.kernel.org
Subject: Gentoo Linux BUG 18612 - cfdisk
Message-ID: <20030403171148.GI26830@lostlogicx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux found 2.4.20-lolo-r2_pre5
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugs.gentoo.org/show_bug.cgi?id=18612

This bug appears to be caused by using cfdisk's default allocation on the last partition on a drive.  From the looks of it on the user's LBA mapped drive, cfdisk allocated a bunch of non-existant sectors when the user allowed it to pick the default size for that last partition.

--Brandon Low
