Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbVHHRps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbVHHRps (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 13:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbVHHRps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 13:45:48 -0400
Received: from dude3.usprocom.net ([69.222.0.8]:23812 "EHLO usfltd.com")
	by vger.kernel.org with ESMTP id S932155AbVHHRpr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 13:45:47 -0400
Date: Mon,  8 Aug 2005 12:45:54 -0500
Message-Id: <200508081245.AA36831876@usfltd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "art" <art@usfltd.com>
Reply-To: <art@usfltd.com>
To: <linux-kernel@vger.kernel.org>
CC: <torvalds@osdl.org>
Subject: Re: Linux-2.6.13-rc6: aic7xxx testers please..-deadlock
X-Mailer: <IMail v8.05>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel 2.6.13-rc1-git7 to 2.6.13-rc5 transfer 72MB/s on aha19160 with 15k rpm seagate with reiserfs3 but possible deadlock in heavy IO - rsync ~50000-small files from /mnt/seagate15k/a to /mnt/seagate15k/b ends in middle with deadlock of rsync (3 instances), pdflush, and gam_server all of them in uninteruptible state -- root cannot kill this deadlocked uninterruptibles, so reboot by reset

art@usfltd.com

