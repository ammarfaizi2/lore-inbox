Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266660AbUGQAGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266660AbUGQAGY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 20:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266662AbUGQAGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 20:06:22 -0400
Received: from muss.CIS.McMaster.CA ([130.113.64.9]:16115 "EHLO
	cgpsrv1.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S266660AbUGQAGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 20:06:16 -0400
From: Gabriel Devenyi <devenyga@mcmaster.ca>
To: ck@vds.kolivas.org, linux-kernel@vger.kernel.org
Subject: Preempt Violation
Date: Fri, 16 Jul 2004 20:06:23 -0400
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407162006.23456.devenyga@mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one looks particularly nasty.

20ms non-preemptible critical section violated 4 ms preempt threshold starting 
a                                                                                        
t sys_ioctl+0x42/0x260 and ending at sys_ioctl+0xbd/0x260
 [<c015881d>] sys_ioctl+0xbd/0x260
 [<c0116510>] dec_preempt_count+0x110/0x120
 [<c015881d>] sys_ioctl+0xbd/0x260
 [<c0103e95>] sysenter_past_esp+0x52/0x71

-- 
Gabriel Devenyi
devenyga@mcmaster.ca
