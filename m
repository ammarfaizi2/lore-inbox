Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932646AbVKXTmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932646AbVKXTmM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 14:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbVKXTmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 14:42:12 -0500
Received: from mtl.rackplans.net ([65.39.167.249]:39843 "HELO innerfire.net")
	by vger.kernel.org with SMTP id S932646AbVKXTmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 14:42:11 -0500
Date: Thu, 24 Nov 2005 14:42:07 -0500 (EST)
From: Gerhard Mack <gmack@innerfire.net>
To: linux-kernel@vger.kernel.org
Subject: linux-2.6.15-rc2 build errors in ext3 on amd64
Message-ID: <Pine.LNX.4.64.0511241441270.21510@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When attempting to compile on my amd64 I get this:

  CHK     include/linux/version.h
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
  CC      arch/x86_64/ia32/ia32_ioctl.o
In file included from include/linux/ext3_jbd.h:20,
                 from fs/compat_ioctl.c:52,
                 from arch/x86_64/ia32/ia32_ioctl.c:14:
include/linux/ext3_fs.h: In function 'ext3_raw_inode':
include/linux/ext3_fs.h:696: error: dereferencing pointer to incomplete type
include/linux/ext3_fs.h: At top level:
include/linux/ext3_fs.h:734: error: syntax error before '*' token
include/linux/ext3_fs.h:734: warning: function declaration isn't a prototype
include/linux/ext3_fs.h:735: error: syntax error before '*' token
include/linux/ext3_fs.h:736: warning: function declaration isn't a prototype
include/linux/ext3_fs.h:737: error: syntax error before '*' token
include/linux/ext3_fs.h:738: warning: function declaration isn't a prototype
include/linux/ext3_fs.h:765: error: syntax error before '*' token
include/linux/ext3_fs.h:765: warning: function declaration isn't a prototype
include/linux/ext3_fs.h:766: error: syntax error before '*' token
include/linux/ext3_fs.h:766: warning: function declaration isn't a prototype
include/linux/ext3_fs.h:775: error: syntax error before '*' token
include/linux/ext3_fs.h:775: warning: function declaration isn't a prototype
include/linux/ext3_fs.h:776: error: syntax error before '*' token
include/linux/ext3_fs.h:776: warning: function declaration isn't a prototype
include/linux/ext3_fs.h:777: error: syntax error before '*' token
include/linux/ext3_fs.h:777: warning: function declaration isn't a prototype
include/linux/ext3_fs.h:783: error: syntax error before '*' token
include/linux/ext3_fs.h:783: warning: function declaration isn't a prototype
include/linux/ext3_fs.h:797: error: syntax error before '*' token
include/linux/ext3_fs.h:797: warning: function declaration isn't a prototype
include/linux/ext3_fs.h:798: error: syntax error before '*' token
include/linux/ext3_fs.h:798: warning: function declaration isn't a prototype
In file included from fs/compat_ioctl.c:52,
                 from arch/x86_64/ia32/ia32_ioctl.c:14:
include/linux/ext3_jbd.h:91: error: syntax error before '*' token
include/linux/ext3_jbd.h:93: warning: function declaration isn't a prototype
include/linux/ext3_jbd.h:100: error: syntax error before '*' token
include/linux/ext3_jbd.h:101: warning: function declaration isn't a prototype
include/linux/ext3_jbd.h:103: error: syntax error before '*' token
include/linux/ext3_jbd.h:103: warning: function declaration isn't a prototype
include/linux/ext3_jbd.h:113: error: syntax error before 'handle_t'
include/linux/ext3_jbd.h:113: warning: function declaration isn't a prototype
include/linux/ext3_jbd.h:116: error: syntax error before 'handle_t'
include/linux/ext3_jbd.h:118: warning: function declaration isn't a prototype
include/linux/ext3_jbd.h: In function '__ext3_journal_get_undo_access':
include/linux/ext3_jbd.h:119: warning: implicit declaration of function 'journal_get_undo_access'
include/linux/ext3_jbd.h:119: error: 'handle' undeclared (first use in this function)
include/linux/ext3_jbd.h:119: error: (Each undeclared identifier is reported only once
include/linux/ext3_jbd.h:119: error: for each function it appears in.)
include/linux/ext3_jbd.h:119: error: 'bh' undeclared (first use in this function)
include/linux/ext3_jbd.h:121: error: 'where' undeclared (first use in this function)
include/linux/ext3_jbd.h: At top level:
include/linux/ext3_jbd.h:126: error: syntax error before 'handle_t'
include/linux/ext3_jbd.h:128: warning: function declaration isn't a prototype
include/linux/ext3_jbd.h: In function '__ext3_journal_get_write_access':
include/linux/ext3_jbd.h:129: warning: implicit declaration of function 'journal_get_write_access'
include/linux/ext3_jbd.h:129: error: 'handle' undeclared (first use in this function)
include/linux/ext3_jbd.h:129: error: 'bh' undeclared (first use in this function)
include/linux/ext3_jbd.h:131: error: 'where' undeclared (first use in this function)
include/linux/ext3_jbd.h: At top level:
include/linux/ext3_jbd.h:136: error: syntax error before '*' token
include/linux/ext3_jbd.h:137: warning: function declaration isn't a prototype
include/linux/ext3_jbd.h: In function 'ext3_journal_release_buffer':
include/linux/ext3_jbd.h:138: warning: implicit declaration of function 'journal_release_buffer'
include/linux/ext3_jbd.h:138: error: 'handle' undeclared (first use in this function)
include/linux/ext3_jbd.h:138: error: 'bh' undeclared (first use in this function)
include/linux/ext3_jbd.h: At top level:
include/linux/ext3_jbd.h:142: error: syntax error before 'handle_t'
include/linux/ext3_jbd.h:143: warning: function declaration isn't a prototype
include/linux/ext3_jbd.h: In function '__ext3_journal_forget':
include/linux/ext3_jbd.h:144: warning: implicit declaration of function 'journal_forget'
include/linux/ext3_jbd.h:144: error: 'handle' undeclared (first use in this function)
include/linux/ext3_jbd.h:144: error: 'bh' undeclared (first use in this function)
include/linux/ext3_jbd.h:146: error: 'where' undeclared (first use in this function)
include/linux/ext3_jbd.h: At top level:
include/linux/ext3_jbd.h:151: error: syntax error before 'handle_t'
include/linux/ext3_jbd.h:153: warning: function declaration isn't a prototype
include/linux/ext3_jbd.h: In function '__ext3_journal_revoke':
include/linux/ext3_jbd.h:154: warning: implicit declaration of function 'journal_revoke'
include/linux/ext3_jbd.h:154: error: 'handle' undeclared (first use in this function)
include/linux/ext3_jbd.h:154: error: 'blocknr' undeclared (first use in this function)
include/linux/ext3_jbd.h:154: error: 'bh' undeclared (first use in this function)
include/linux/ext3_jbd.h:156: error: 'where' undeclared (first use in this function)
include/linux/ext3_jbd.h: At top level:
include/linux/ext3_jbd.h:162: error: syntax error before 'handle_t'
include/linux/ext3_jbd.h:163: warning: function declaration isn't a prototype
include/linux/ext3_jbd.h: In function '__ext3_journal_get_create_access':
include/linux/ext3_jbd.h:164: warning: implicit declaration of function 'journal_get_create_access'
include/linux/ext3_jbd.h:164: error: 'handle' undeclared (first use in this function)
include/linux/ext3_jbd.h:164: error: 'bh' undeclared (first use in this function)
include/linux/ext3_jbd.h:166: error: 'where' undeclared (first use in this function)
include/linux/ext3_jbd.h: At top level:
include/linux/ext3_jbd.h:172: error: syntax error before 'handle_t'
include/linux/ext3_jbd.h:173: warning: function declaration isn't a prototype
include/linux/ext3_jbd.h: In function '__ext3_journal_dirty_metadata':
include/linux/ext3_jbd.h:174: warning: implicit declaration of function 'journal_dirty_metadata'
include/linux/ext3_jbd.h:174: error: 'handle' undeclared (first use in this function)
include/linux/ext3_jbd.h:174: error: 'bh' undeclared (first use in this function)
include/linux/ext3_jbd.h:176: error: 'where' undeclared (first use in this function)
include/linux/ext3_jbd.h: At top level:
include/linux/ext3_jbd.h:194: error: syntax error before '*' token
include/linux/ext3_jbd.h:194: warning: function declaration isn't a prototype
include/linux/ext3_jbd.h:196: error: syntax error before '*' token
include/linux/ext3_jbd.h:196: warning: type defaults to 'int' in declaration of 'ext3_journal_start_sb'
include/linux/ext3_jbd.h:196: warning: data definition has no type or storage class
include/linux/ext3_jbd.h:197: error: syntax error before 'handle_t'
include/linux/ext3_jbd.h:197: warning: function declaration isn't a prototype
include/linux/ext3_jbd.h:199: error: syntax error before '*' token
include/linux/ext3_jbd.h:200: warning: return type defaults to 'int'
include/linux/ext3_jbd.h:207: error: syntax error before '*' token
include/linux/ext3_jbd.h:208: warning: return type defaults to 'int'
include/linux/ext3_jbd.h: In function 'ext3_journal_current_handle':
include/linux/ext3_jbd.h:209: warning: implicit declaration of function 'journal_current_handle'
include/linux/ext3_jbd.h:209: warning: return makes pointer from integer without a cast
include/linux/ext3_jbd.h: At top level:
include/linux/ext3_jbd.h:212: error: syntax error before '*' token
include/linux/ext3_jbd.h:213: warning: function declaration isn't a prototype
include/linux/ext3_jbd.h: In function 'ext3_journal_extend':
include/linux/ext3_jbd.h:214: warning: implicit declaration of function 'journal_extend'
include/linux/ext3_jbd.h:214: error: 'handle' undeclared (first use in this function)
include/linux/ext3_jbd.h:214: error: 'nblocks' undeclared (first use in this function)
include/linux/ext3_jbd.h: At top level:
include/linux/ext3_jbd.h:217: error: syntax error before '*' token
include/linux/ext3_jbd.h:218: warning: function declaration isn't a prototype
include/linux/ext3_jbd.h: In function 'ext3_journal_restart':
include/linux/ext3_jbd.h:219: warning: implicit declaration of function 'journal_restart'
include/linux/ext3_jbd.h:219: error: 'handle' undeclared (first use in this function)
include/linux/ext3_jbd.h:219: error: 'nblocks' undeclared (first use in this function)
include/linux/ext3_jbd.h: In function 'ext3_journal_blocks_per_page':
include/linux/ext3_jbd.h:224: warning: implicit declaration of function 'journal_blocks_per_page'
include/linux/ext3_jbd.h: At top level:
include/linux/ext3_jbd.h:227: error: syntax error before '*' token
include/linux/ext3_jbd.h:228: warning: function declaration isn't a prototype
include/linux/ext3_jbd.h: In function 'ext3_journal_force_commit':
include/linux/ext3_jbd.h:229: warning: implicit declaration of function 'journal_force_commit'
include/linux/ext3_jbd.h:229: error: 'journal' undeclared (first use in this function)
make[1]: *** [arch/x86_64/ia32/ia32_ioctl.o] Error 1
make: *** [arch/x86_64/ia32] Error 2

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.
