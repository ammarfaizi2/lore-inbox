Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271924AbTHEVJo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 17:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271969AbTHEVJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 17:09:43 -0400
Received: from [163.118.102.59] ([163.118.102.59]:14999 "EHLO
	mail.drunkencodepoets.com") by vger.kernel.org with ESMTP
	id S271924AbTHEVJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 17:09:26 -0400
Date: Tue, 5 Aug 2003 17:05:58 -0400
From: s0be <s0be@DrunkenCodePoets.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel Oops in 2.6.0-test2-mm4
Message-Id: <20030805170558.3ee38204.s0be@DrunkenCodePoets.com>
Organization: DrunkenCodePoets.com
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

here's the oops from dmesg and the surrounding messages.  I'm guessing it was caused by smb, but I can't confirm it.  trying to recreate it.

SMB connection re-established (-5)
smb_errno: class ERRSRV, code 91 from command 0x80
SMB connection re-established (-5)
smb_errno: class ERRSRV, code 91 from command 0x80
SMB connection re-established (-5)
smb_errno: class ERRSRV, code 91 from command 0x80
SMB connection re-established (-5)
smb_errno: class ERRSRV, code 91 from command 0x80
Debug: sleeping function called from invalid context at include/asm/uaccess.h:512Call Trace:
 [<c011fd3c>] __might_sleep+0x5c/0x5e
 [<c010da1a>] save_v86_state+0x6a/0x200
 [<c010e565>] handle_vm86_fault+0xa5/0x8c0
 [<c0170a23>] dput+0x23/0x200
 [<c010c030>] do_general_protection+0x0/0xa0
 [<c032519f>] error_code+0x2f/0x38
 [<c0324733>] syscall_call+0x7/0xb

SMB connection re-established (-5)
smb_errno: class ERRSRV, code 91 from command 0x80
XFS mounting filesystem hda1

pat

-- 
