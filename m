Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266245AbUGPBqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266245AbUGPBqz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 21:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266133AbUGPBqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 21:46:54 -0400
Received: from muss.CIS.McMaster.CA ([130.113.64.9]:40871 "EHLO
	cgpsrv1.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S266289AbUGPBqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 21:46:52 -0400
From: Gabriel Devenyi <devenyga@mcmaster.ca>
To: ck@vds.kolivas.org, linux-kernel@vger.kernel.org
Subject: More Preempt Violations
Date: Thu, 15 Jul 2004 21:46:52 -0400
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407152146.52196.devenyga@mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was after playing zsnes for ~3 hours with kopete on the side.

5ms non-preemptible critical section violated 4 ms preempt threshold starting 
at
 sys_ioctl+0x42/0x260 and ending at sys_ioctl+0xbd/0x260
 [<c015881d>] sys_ioctl+0xbd/0x260
 [<c0116510>] dec_preempt_count+0x110/0x120
 [<c0384641>] xdr_sendpages+0x241/0x270
 [<c015881d>] sys_ioctl+0xbd/0x260
 [<c0147d08>] sys_read+0x38/0x60
 [<c0103e95>] sysenter_past_esp+0x52/0x71
 [<c0384641>] xdr_sendpages+0x241/0x270
5ms non-preemptible critical section violated 4 ms preempt threshold starting 
at
 sys_ioctl+0x42/0x260 and ending at sys_ioctl+0xbd/0x260
 [<c015881d>] sys_ioctl+0xbd/0x260
 [<c0116510>] dec_preempt_count+0x110/0x120
 [<c0384641>] xdr_sendpages+0x241/0x270
 [<c015881d>] sys_ioctl+0xbd/0x260
 [<c0147d08>] sys_read+0x38/0x60
 [<c0103e95>] sysenter_past_esp+0x52/0x71
 [<c0384641>] xdr_sendpages+0x241/0x270
6ms non-preemptible critical section violated 4 ms preempt threshold starting 
at
 sys_ioctl+0x42/0x260 and ending at sys_ioctl+0xbd/0x260
 [<c015881d>] sys_ioctl+0xbd/0x260
 [<c0116510>] dec_preempt_count+0x110/0x120
 [<c0384641>] xdr_sendpages+0x241/0x270
 [<c015881d>] sys_ioctl+0xbd/0x260
 [<c0147d08>] sys_read+0x38/0x60
 [<c0103e95>] sysenter_past_esp+0x52/0x71
 [<c0384641>] xdr_sendpages+0x241/0x270
5ms non-preemptible critical section violated 4 ms preempt threshold starting 
at                                       sys_ioctl+0x42/0x260 and ending at 
sys_ioctl+0xbd/0x260
 [<c015881d>] sys_ioctl+0xbd/0x260
 [<c0116510>] dec_preempt_count+0x110/0x120
 [<c0384641>] xdr_sendpages+0x241/0x270
 [<c015881d>] sys_ioctl+0xbd/0x260
 [<c0103e95>] sysenter_past_esp+0x52/0x71
 [<c0384641>] xdr_sendpages+0x241/0x270
5ms non-preemptible critical section violated 4 ms preempt threshold starting 
at                                       sys_ioctl+0x42/0x260 and ending at 
sys_ioctl+0xbd/0x260
 [<c015881d>] sys_ioctl+0xbd/0x260
 [<c0116510>] dec_preempt_count+0x110/0x120
 [<c0384641>] xdr_sendpages+0x241/0x270
 [<c015881d>] sys_ioctl+0xbd/0x260
 [<c0103e95>] sysenter_past_esp+0x52/0x71
 [<c0384641>] xdr_sendpages+0x241/0x270

-- 
Gabriel Devenyi
devenyga@mcmaster.ca
