Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269987AbTHJQUP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 12:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269994AbTHJQUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 12:20:14 -0400
Received: from colossus.systems.pipex.net ([62.241.160.73]:35459 "EHLO
	colossus.systems.pipex.net") by vger.kernel.org with ESMTP
	id S269987AbTHJQUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 12:20:12 -0400
Date: Sun, 10 Aug 2003 17:19:51 +0100
From: Stig Brautaset <stig@brautaset.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test3: Debug: sleeping function called from invalid context at include/asm/uaccess.h:473
Message-ID: <20030810161951.GA1009@brautaset.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I just got this message on a 2.6.0-test3 kernel:

Debug: sleeping function called from invalid context at include/asm/uaccess.h:473
Call Trace:
 [<c0117c01>] __might_sleep+0x61/0x80
 [<c010ba18>] save_v86_state+0x68/0x210
 [<c01362f5>] generic_file_aio_write+0x85/0xb0
 [<c010c547>] handle_vm86_fault+0xb7/0xa10
 [<c0181a2f>] ext3_file_write+0x3f/0xd0
 [<c010a330>] do_general_protection+0x0/0xa0
 [<c0109625>] error_code+0x2d/0x38
 [<c010947b>] syscall_call+0x7/0xb

I'm unsure what other information is needed, if any. 
I'm not on list, so CC me on replies please.



-- 
brautaset.org
