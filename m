Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbVAJEEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbVAJEEY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 23:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbVAJEEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 23:04:22 -0500
Received: from animx.eu.org ([216.98.75.249]:30594 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S262067AbVAJEEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 23:04:11 -0500
Date: Sun, 9 Jan 2005 23:15:31 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: High load with adaptec scsi cards?
Message-ID: <20050110041530.GA5669@animx.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using 2.6.10 with 3 adaptec scsi cards.  All 3 cards (onboard aic78xx
chip 2ch, aha-2940u/uw, aha-39160) that I use have this same problem.  When
I do heavy I/O to any disk, the load goes way up and the cpu usage goes to
100%

Top shows:
Cpu0  :  0.7% us,  7.3% sy,  0.0% ni,  2.7% id, 87.0% wa,  0.0% hi,  2.3% si
Cpu1  :  0.0% us,  0.0% sy,  0.0% ni, 97.7% id,  2.3% wa,  0.0% hi,  0.0% si

however, I do not see any program using all the cpu time int he process
list.  The program doing all the disk I/O uses ~8% cpu.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
