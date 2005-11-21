Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbVKUMxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbVKUMxi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 07:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbVKUMxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 07:53:38 -0500
Received: from smtp-out6.blueyonder.co.uk ([195.188.213.9]:62545 "EHLO
	smtp-out6.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S932288AbVKUMxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 07:53:37 -0500
Message-ID: <4381C34D.2030904@blueyonder.co.uk>
Date: Mon, 21 Nov 2005 12:53:33 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6.15-rc2 x86_64 build fails if ext3 not selected
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 21 Nov 2005 12:54:27.0676 (UTC) FILETIME=[B4DE29C0:01C5EE9A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This only affects x86_64, with ext3 selected the build succeeds.

   AS [M]  arch/x86_64/crypto/aes-x86_64-asm.o
   CC [M]  arch/x86_64/crypto/aes.o
   LD [M]  arch/x86_64/crypto/aes-x86_64.o
   AS      arch/x86_64/ia32/ia32entry.o
   CC      arch/x86_64/ia32/sys_ia32.o
   CC      arch/x86_64/ia32/ia32_ioctl.o
In file included from include/linux/ext3_jbd.h:20,
                  from fs/compat_ioctl.c:52,
                  from arch/x86_64/ia32/ia32_ioctl.c:14:
include/linux/ext3_fs.h: In function ‘ext3_raw_inode’:
include/linux/ext3_fs.h:696: error: dereferencing pointer to incomplete type
include/linux/ext3_fs.h: At top level:
include/linux/ext3_fs.h:734: error: syntax error before ‘*’ token
include/linux/ext3_fs.h:734: warning: function declaration isn’t a prototype
include/linux/ext3_fs.h:735: error: syntax error before ‘*’ token
include/linux/ext3_fs.h:736: warning: function declaration isn’t a prototype
include/linux/ext3_fs.h:737: error: syntax error before ‘*’ token
include/linux/ext3_fs.h:738: warning: function declaration isn’t a prototype
include/linux/ext3_fs.h:765: error: syntax error before ‘*’ token
include/linux/ext3_fs.h:765: warning: function declaration isn’t a prototype
include/linux/ext3_fs.h:766: error: syntax error before ‘*’ token
include/linux/ext3_fs.h:766: warning: function declaration isn’t a prototype
include/linux/ext3_fs.h:775: error: syntax error before ‘*’ token
include/linux/ext3_fs.h:775: warning: function declaration isn’t a prototype
include/linux/ext3_fs.h:776: error: syntax error before ‘*’ token
include/linux/ext3_fs.h:776: warning: function declaration isn’t a prototype
include/linux/ext3_fs.h:777: error: syntax error before ‘*’ token
include/linux/ext3_fs.h:777: warning: function declaration isn’t a prototype
include/linux/ext3_fs.h:783: error: syntax error before ‘*’ token
include/linux/ext3_fs.h:783: warning: function declaration isn’t a prototype
include/linux/ext3_fs.h:797: error: syntax error before ‘*’ token
include/linux/ext3_fs.h:797: warning: function declaration isn’t a prototype
include/linux/ext3_fs.h:798: error: syntax error before ‘*’ token
include/linux/ext3_fs.h:798: warning: function declaration isn’t a prototype
In file included from fs/compat_ioctl.c:52,

Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, licensed Private Pilot
Retired IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support 
Specialist
Microsoft Windows Free Zone - Linux used for all Computing Tasks
