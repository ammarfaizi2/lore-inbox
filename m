Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265373AbSKKDZA>; Sun, 10 Nov 2002 22:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265382AbSKKDZA>; Sun, 10 Nov 2002 22:25:00 -0500
Received: from [24.206.178.254] ([24.206.178.254]:145 "HELO
	www.maxconsulting.biz") by vger.kernel.org with SMTP
	id <S265373AbSKKDYx>; Sun, 10 Nov 2002 22:24:53 -0500
Message-ID: <3DCF24CE.7090405@brianandsara.net>
Date: Sun, 10 Nov 2002 21:32:30 -0600
From: Brian Jackson <brian@brianandsara.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020930
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.46-bk6 kconfig errors
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just downloaded bk6 and I get the following errors when I do a make 
menuconfig. Same thing happens whether I have a  .config already or not. 
If you need any more info let me know.

--Brian Jackson

   rm -f scripts/built-in.o; ar rcs scripts/built-in.o
  gcc -Wp,-MD,scripts/.fixdep.d -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer   -o scripts/fixdep scripts/fixdep.c
  gcc -Wp,-MD,scripts/.split-include.d -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer   -o scripts/split-include scripts/split-include.c
  gcc -Wp,-MD,scripts/.docproc.d -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer   -o scripts/docproc scripts/docproc.c
  gcc -Wp,-MD,scripts/.conmakehash.d -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer   -o scripts/conmakehash scripts/conmakehash.c
  cat scripts/kconfig/zconf.tab.h_shipped > scripts/kconfig/zconf.tab.h
  gcc -Wp,-MD,scripts/kconfig/.conf.o.d -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer   -c -o scripts/kconfig/conf.o scripts/kconfig/conf.c
scripts/kconfig/conf.c:1: parse error before '=' token
scripts/kconfig/conf.c:21: parse error before '!=' token
scripts/kconfig/conf.c:21: warning: type defaults to `int' in 
declaration of `ASSERT'
scripts/kconfig/conf.c:21: warning: function declaration isn't a prototype
scripts/kconfig/conf.c:21: warning: data definition has no type or 
storage class
scripts/kconfig/conf.c:30: warning: type defaults to `int' in 
declaration of `error'
scripts/kconfig/conf.c:30: warning: implicit declaration of function 
`XFS_ERROR'
scripts/kconfig/conf.c:30: `EMLINK' undeclared here (not in a function)
scripts/kconfig/conf.c:30: initializer element is not constant
scripts/kconfig/conf.c:30: warning: data definition has no type or 
storage class
scripts/kconfig/conf.c:31: warning: type defaults to `int' in 
declaration of `xfs_rename_unlock4'
scripts/kconfig/conf.c:31: warning: parameter names (without types) in 
function declaration
scripts/kconfig/conf.c:31: warning: data definition has no type or 
storage class
scripts/kconfig/conf.c:32: parse error before "goto"
scripts/kconfig/conf.c:36: warning: type defaults to `int' in 
declaration of `new_parent'
scripts/kconfig/conf.c:36: `src_dp' undeclared here (not in a function)
scripts/kconfig/conf.c:36: `target_dp' undeclared here (not in a function)
scripts/kconfig/conf.c:36: warning: data definition has no type or 
storage class
scripts/kconfig/conf.c:37: warning: type defaults to `int' in 
declaration of `src_is_directory'
scripts/kconfig/conf.c:37: `src_ip' undeclared here (not in a function)
scripts/kconfig/conf.c:37: `IFMT' undeclared here (not in a function)
scripts/kconfig/conf.c:37: `IFDIR' undeclared here (not in a function)
scripts/kconfig/conf.c:37: warning: data definition has no type or 
storage class
scripts/kconfig/conf.c:43: warning: type defaults to `int' in 
declaration of `xfs_rename_unlock4'
scripts/kconfig/conf.c:43: warning: parameter names (without types) in 
function declaration
scripts/kconfig/conf.c:43: warning: data definition has no type or 
storage class
scripts/kconfig/conf.c:45: parse error before '&' token
scripts/kconfig/conf.c:45: warning: type defaults to `int' in 
declaration of `XFS_BMAP_INIT'
scripts/kconfig/conf.c:45: warning: function declaration isn't a prototype
scripts/kconfig/conf.c:45: warning: data definition has no type or 
storage class
scripts/kconfig/conf.c:46: warning: type defaults to `int' in 
declaration of `mp'
scripts/kconfig/conf.c:46: `src_dp' undeclared here (not in a function)
scripts/kconfig/conf.c:46: warning: data definition has no type or 
storage class
scripts/kconfig/conf.c:47: warning: type defaults to `int' in 
declaration of `tp'
scripts/kconfig/conf.c:47: warning: implicit declaration of function 
`xfs_trans_alloc'
scripts/kconfig/conf.c:47: `XFS_TRANS_RENAME' undeclared here (not in a 
function)
scripts/kconfig/conf.c:47: initializer element is not constant
scripts/kconfig/conf.c:47: warning: data definition has no type or 
storage class
scripts/kconfig/conf.c:48: warning: type defaults to `int' in 
declaration of `cancel_flags'
scripts/kconfig/conf.c:48: `XFS_TRANS_RELEASE_LOG_RES' undeclared here 
(not in a function)
scripts/kconfig/conf.c:48: warning: data definition has no type or 
storage class
scripts/kconfig/conf.c:49: warning: type defaults to `int' in 
declaration of `spaceres'
scripts/kconfig/conf.c:49: warning: implicit declaration of function 
`XFS_RENAME_SPACE_RES'
scripts/kconfig/conf.c:49: `target_namelen' undeclared here (not in a 
function)
scripts/kconfig/conf.c:49: initializer element is not constant
scripts/kconfig/conf.c:49: warning: data definition has no type or 
storage class
scripts/kconfig/conf.c:50: warning: type defaults to `int' in 
declaration of `error'
scripts/kconfig/conf.c:50: redefinition of `error'
scripts/kconfig/conf.c:30: `error' previously defined here
scripts/kconfig/conf.c:50: warning: implicit declaration of function 
`xfs_trans_reserve'
scripts/kconfig/conf.c:50: warning: implicit declaration of function 
`XFS_RENAME_LOG_RES'
scripts/kconfig/conf.c:51: `XFS_TRANS_PERM_LOG_RES' undeclared here (not 
in a function)
scripts/kconfig/conf.c:51: `XFS_RENAME_LOG_COUNT' undeclared here (not 
in a function)
scripts/kconfig/conf.c:51: initializer element is not constant
scripts/kconfig/conf.c:51: warning: data definition has no type or 
storage class
scripts/kconfig/conf.c:52: parse error before "if"
scripts/kconfig/conf.c:54: warning: type defaults to `int' in 
declaration of `error'
scripts/kconfig/conf.c:54: redefinition of `error'
scripts/kconfig/conf.c:50: `error' previously defined here
scripts/kconfig/conf.c:55: `XFS_TRANS_PERM_LOG_RES' undeclared here (not 
in a function)
scripts/kconfig/conf.c:55: `XFS_RENAME_LOG_COUNT' undeclared here (not 
in a function)
scripts/kconfig/conf.c:55: initializer element is not constant
scripts/kconfig/conf.c:55: warning: data definition has no type or 
storage class
scripts/kconfig/conf.c:56: parse error before '}' token
scripts/kconfig/conf.c:59: parse error before numeric constant
scripts/kconfig/conf.c:59: warning: type defaults to `int' in 
declaration of `xfs_trans_cancel'
scripts/kconfig/conf.c:59: warning: function declaration isn't a prototype
scripts/kconfig/conf.c:59: warning: data definition has no type or 
storage class
scripts/kconfig/conf.c:69: warning: type defaults to `int' in 
declaration of `rename_which_error_return'
scripts/kconfig/conf.c:69: warning: data definition has no type or 
storage class
scripts/kconfig/conf.c:70: parse error before "goto"
scripts/kconfig/conf.c:77: parse error before numeric constant
scripts/kconfig/conf.c:77: warning: type defaults to `int' in 
declaration of `xfs_lock_inodes'
scripts/kconfig/conf.c:77: warning: function declaration isn't a prototype
scripts/kconfig/conf.c:77: warning: data definition has no type or 
storage class
scripts/kconfig/conf.c:87: warning: type defaults to `int' in 
declaration of `VN_HOLD'
scripts/kconfig/conf.c:87: warning: parameter names (without types) in 
function declaration
scripts/kconfig/conf.c:87: warning: data definition has no type or 
storage class
scripts/kconfig/conf.c:88: warning: type defaults to `int' in 
declaration of `xfs_trans_ijoin'
scripts/kconfig/conf.c:88: warning: parameter names (without types) in 
function declaration
scripts/kconfig/conf.c:88: warning: data definition has no type or 
storage class
scripts/kconfig/conf.c:89: parse error before "if"
scripts/kconfig/conf.c:91: warning: type defaults to `int' in 
declaration of `xfs_trans_ijoin'
scripts/kconfig/conf.c:91: warning: parameter names (without types) in 
function declaration
scripts/kconfig/conf.c:91: warning: data definition has no type or 
storage class
scripts/kconfig/conf.c:92: parse error before '}' token
scripts/kconfig/conf.c:122: warning: type defaults to `int' in 
declaration of `error'
scripts/kconfig/conf.c:122: redefinition of `error'
scripts/kconfig/conf.c:54: `error' previously defined here
scripts/kconfig/conf.c:122: warning: implicit declaration of function 
`XFS_DIR_CREATENAME'
scripts/kconfig/conf.c:122: `target_dp' undeclared here (not in a function)
scripts/kconfig/conf.c:122: `target_name' undeclared here (not in a 
function)
scripts/kconfig/conf.c:123: `target_namelen' undeclared here (not in a 
function)
scripts/kconfig/conf.c:123: `src_ip' undeclared here (not in a function)
scripts/kconfig/conf.c:124: `first_block' undeclared here (not in a 
function)
scripts/kconfig/conf.c:124: `free_list' undeclared here (not in a function)
scripts/kconfig/conf.c:124: initializer element is not constant
scripts/kconfig/conf.c:124: warning: data definition has no type or 
storage class
scripts/kconfig/conf.c:125: parse error before "if"
scripts/kconfig/conf.c:133: parse error before '|' token
scripts/kconfig/conf.c:133: warning: type defaults to `int' in 
declaration of `xfs_ichgtime'
scripts/kconfig/conf.c:133: warning: function declaration isn't a prototype
scripts/kconfig/conf.c:133: warning: data definition has no type or 
storage class
scripts/kconfig/conf.c:156: warning: type defaults to `int' in 
declaration of `rename_which_error_return'
scripts/kconfig/conf.c:156: redefinition of `rename_which_error_return'
scripts/kconfig/conf.c:69: `rename_which_error_return' previously 
defined here
scripts/kconfig/conf.c:156: warning: data definition has no type or 
storage class
scripts/kconfig/conf.c:157: parse error before "goto"
scripts/kconfig/conf.c:170: warning: type defaults to `int' in 
declaration of `error'
scripts/kconfig/conf.c:170: redefinition of `error'
scripts/kconfig/conf.c:122: `error' previously defined here
scripts/kconfig/conf.c:170: warning: implicit declaration of function 
`XFS_DIR_REPLACE'
scripts/kconfig/conf.c:170: `target_dp' undeclared here (not in a function)
scripts/kconfig/conf.c:170: `target_name' undeclared here (not in a 
function)
scripts/kconfig/conf.c:171: `target_namelen' undeclared here (not in a 
function)
scripts/kconfig/conf.c:171: `src_ip' undeclared here (not in a function)
scripts/kconfig/conf.c:171: `first_block' undeclared here (not in a 
function)
scripts/kconfig/conf.c:172: `free_list' undeclared here (not in a function)
scripts/kconfig/conf.c:172: initializer element is not constant
scripts/kconfig/conf.c:172: warning: data definition has no type or 
storage class
scripts/kconfig/conf.c:173: parse error before "if"
scripts/kconfig/conf.c:177: parse error before '|' token
scripts/kconfig/conf.c:177: warning: type defaults to `int' in 
declaration of `xfs_ichgtime'
scripts/kconfig/conf.c:177: warning: function declaration isn't a prototype
scripts/kconfig/conf.c:177: warning: data definition has no type or 
storage class
scripts/kconfig/conf.c:183: warning: type defaults to `int' in 
declaration of `error'
scripts/kconfig/conf.c:183: redefinition of `error'
scripts/kconfig/conf.c:170: `error' previously defined here
scripts/kconfig/conf.c:183: warning: implicit declaration of function 
`xfs_droplink'
scripts/kconfig/conf.c:183: `target_ip' undeclared here (not in a function)
scripts/kconfig/conf.c:183: initializer element is not constant
scripts/kconfig/conf.c:183: warning: data definition has no type or 
storage class
scripts/kconfig/conf.c:184: parse error before "if"
scripts/kconfig/conf.c:188: warning: type defaults to `int' in 
declaration of `target_ip_dropped'
scripts/kconfig/conf.c:188: warning: data definition has no type or 
storage class
scripts/kconfig/conf.c:191: warning: type defaults to `int' in 
declaration of `target_link_zero'
scripts/kconfig/conf.c:191: `target_ip' undeclared here (not in a function)
scripts/kconfig/conf.c:191: warning: data definition has no type or 
storage class
scripts/kconfig/conf.c:193: parse error before "if"
scripts/kconfig/conf.c:218: parse error before '!=' token
scripts/kconfig/conf.c:218: warning: type defaults to `int' in 
declaration of `ASSERT'
scripts/kconfig/conf.c:218: warning: function declaration isn't a prototype
scripts/kconfig/conf.c:218: warning: data definition has no type or 
storage class
scripts/kconfig/conf.c:223: parse error before '|' token
scripts/kconfig/conf.c:223: warning: type defaults to `int' in 
declaration of `xfs_ichgtime'
scripts/kconfig/conf.c:223: warning: function declaration isn't a prototype
scripts/kconfig/conf.c:223: warning: data definition has no type or 
storage class
scripts/kconfig/conf.c:256: warning: type defaults to `int' in 
declaration of `error'
scripts/kconfig/conf.c:256: redefinition of `error'
scripts/kconfig/conf.c:183: `error' previously defined here
scripts/kconfig/conf.c:256: warning: implicit declaration of function 
`XFS_DIR_REMOVENAME'
scripts/kconfig/conf.c:256: `src_dp' undeclared here (not in a function)
scripts/kconfig/conf.c:256: `src_name' undeclared here (not in a function)
scripts/kconfig/conf.c:256: `src_namelen' undeclared here (not in a 
function)
scripts/kconfig/conf.c:257: `src_ip' undeclared here (not in a function)
scripts/kconfig/conf.c:257: `first_block' undeclared here (not in a 
function)
scripts/kconfig/conf.c:257: `free_list' undeclared here (not in a function)
scripts/kconfig/conf.c:257: initializer element is not constant
scripts/kconfig/conf.c:257: warning: data definition has no type or 
storage class
scripts/kconfig/conf.c:258: parse error before "if"
scripts/kconfig/conf.c:262: parse error before '|' token
scripts/kconfig/conf.c:262: warning: type defaults to `int' in 
declaration of `xfs_ichgtime'
scripts/kconfig/conf.c:262: warning: function declaration isn't a prototype
scripts/kconfig/conf.c:262: warning: data definition has no type or 
storage class
scripts/kconfig/conf.c:268: parse error before '->' token
scripts/kconfig/conf.c:269: warning: type defaults to `int' in 
declaration of `xfs_trans_log_inode'
scripts/kconfig/conf.c:269: warning: parameter names (without types) in 
function declaration
scripts/kconfig/conf.c:269: warning: data definition has no type or 
storage class
scripts/kconfig/conf.c:271: parse error before "if"
scripts/kconfig/conf.c:273: warning: type defaults to `int' in 
declaration of `xfs_trans_log_inode'
scripts/kconfig/conf.c:273: warning: parameter names (without types) in 
function declaration
scripts/kconfig/conf.c:273: warning: data definition has no type or 
storage class
scripts/kconfig/conf.c:274: parse error before '}' token
scripts/kconfig/conf.c:334:17: xfs.h: No such file or directory
In file included from /usr/include/linux/sched.h:14,
                 from /usr/include/linux/mm.h:4,
                 from scripts/kconfig/conf.c:335:
/usr/include/linux/timex.h:173: field `time' has incomplete type
In file included from /usr/include/asm/pgtable.h:17,
                 from /usr/include/linux/pagemap.h:15,
                 from scripts/kconfig/conf.c:336:
/usr/include/asm/fixmap.h:77: parse error before "pgprot_t"
In file included from /usr/include/linux/pagemap.h:15,
                 from scripts/kconfig/conf.c:336:
/usr/include/asm/pgtable.h:24: parse error before "swapper_pg_dir"
In file included from /usr/include/asm/pgtable.h:116,
                 from /usr/include/linux/pagemap.h:15,
                 from scripts/kconfig/conf.c:336:
/usr/include/asm/pgtable-2level.h:32: parse error before "pgd"
/usr/include/asm/pgtable-2level.h:33: parse error before "pgd"
/usr/include/asm/pgtable-2level.h:34: parse error before "pgd"
/usr/include/asm/pgtable-2level.h:53: parse error before '*' token
/usr/include/asm/pgtable-2level.h:53: parse error before '*' token
/usr/include/asm/pgtable-2level.h: In function `pmd_offset':
/usr/include/asm/pgtable-2level.h:55: `pmd_t' undeclared (first use in 
this function)
/usr/include/asm/pgtable-2level.h:55: (Each undeclared identifier is 
reported only once
/usr/include/asm/pgtable-2level.h:55: for each function it appears in.)
/usr/include/asm/pgtable-2level.h:55: parse error before ')' token
In file included from /usr/include/linux/pagemap.h:15,
                 from scripts/kconfig/conf.c:336:
/usr/include/asm/pgtable.h: At top level:
/usr/include/asm/pgtable.h:274: parse error before "pte"
/usr/include/asm/pgtable.h: In function `pte_read':
/usr/include/asm/pgtable.h:274: `pte' undeclared (first use in this 
function)
/usr/include/asm/pgtable.h: At top level:
/usr/include/asm/pgtable.h:275: parse error before "pte"
/usr/include/asm/pgtable.h: In function `pte_exec':
/usr/include/asm/pgtable.h:275: `pte' undeclared (first use in this 
function)
/usr/include/asm/pgtable.h: At top level:
/usr/include/asm/pgtable.h:276: parse error before "pte"
/usr/include/asm/pgtable.h: In function `pte_dirty':
/usr/include/asm/pgtable.h:276: `pte' undeclared (first use in this 
function)
/usr/include/asm/pgtable.h: At top level:
/usr/include/asm/pgtable.h:277: parse error before "pte"
/usr/include/asm/pgtable.h: In function `pte_young':
/usr/include/asm/pgtable.h:277: `pte' undeclared (first use in this 
function)
/usr/include/asm/pgtable.h: At top level:
/usr/include/asm/pgtable.h:278: parse error before "pte"
/usr/include/asm/pgtable.h: In function `pte_write':
/usr/include/asm/pgtable.h:278: `pte' undeclared (first use in this 
function)
/usr/include/asm/pgtable.h: At top level:
/usr/include/asm/pgtable.h:280: parse error before "pte_rdprotect"
/usr/include/asm/pgtable.h:280: parse error before "pte"
/usr/include/asm/pgtable.h: In function `pte_rdprotect':
/usr/include/asm/pgtable.h:280: `pte' undeclared (first use in this 
function)
/usr/include/asm/pgtable.h: At top level:
/usr/include/asm/pgtable.h:281: parse error before "pte_exprotect"
/usr/include/asm/pgtable.h:281: parse error before "pte"
/usr/include/asm/pgtable.h: In function `pte_exprotect':
/usr/include/asm/pgtable.h:281: `pte' undeclared (first use in this 
function)
/usr/include/asm/pgtable.h: At top level:
/usr/include/asm/pgtable.h:282: parse error before "pte_mkclean"
/usr/include/asm/pgtable.h:282: parse error before "pte"
/usr/include/asm/pgtable.h: In function `pte_mkclean':
/usr/include/asm/pgtable.h:282: `pte' undeclared (first use in this 
function)
/usr/include/asm/pgtable.h: At top level:
/usr/include/asm/pgtable.h:283: parse error before "pte_mkold"
/usr/include/asm/pgtable.h:283: parse error before "pte"
/usr/include/asm/pgtable.h: In function `pte_mkold':
/usr/include/asm/pgtable.h:283: `pte' undeclared (first use in this 
function)
/usr/include/asm/pgtable.h: At top level:
/usr/include/asm/pgtable.h:284: parse error before "pte_wrprotect"
/usr/include/asm/pgtable.h:284: parse error before "pte"
/usr/include/asm/pgtable.h: In function `pte_wrprotect':
/usr/include/asm/pgtable.h:284: `pte' undeclared (first use in this 
function)
/usr/include/asm/pgtable.h: At top level:
/usr/include/asm/pgtable.h:285: parse error before "pte_mkread"
/usr/include/asm/pgtable.h:285: parse error before "pte"
/usr/include/asm/pgtable.h: In function `pte_mkread':
/usr/include/asm/pgtable.h:285: `pte' undeclared (first use in this 
function)
/usr/include/asm/pgtable.h: At top level:
/usr/include/asm/pgtable.h:286: parse error before "pte_mkexec"
/usr/include/asm/pgtable.h:286: parse error before "pte"
/usr/include/asm/pgtable.h: In function `pte_mkexec':
/usr/include/asm/pgtable.h:286: `pte' undeclared (first use in this 
function)
/usr/include/asm/pgtable.h: At top level:
/usr/include/asm/pgtable.h:287: parse error before "pte_mkdirty"
/usr/include/asm/pgtable.h:287: parse error before "pte"
/usr/include/asm/pgtable.h: In function `pte_mkdirty':
/usr/include/asm/pgtable.h:287: `pte' undeclared (first use in this 
function)
/usr/include/asm/pgtable.h: At top level:
/usr/include/asm/pgtable.h:288: parse error before "pte_mkyoung"
/usr/include/asm/pgtable.h:288: parse error before "pte"
/usr/include/asm/pgtable.h: In function `pte_mkyoung':
/usr/include/asm/pgtable.h:288: `pte' undeclared (first use in this 
function)
/usr/include/asm/pgtable.h: At top level:
/usr/include/asm/pgtable.h:289: parse error before "pte_mkwrite"
/usr/include/asm/pgtable.h:289: parse error before "pte"
/usr/include/asm/pgtable.h: In function `pte_mkwrite':
/usr/include/asm/pgtable.h:289: `pte' undeclared (first use in this 
function)
/usr/include/asm/pgtable.h: At top level:
/usr/include/asm/pgtable.h:291: parse error before '*' token
/usr/include/asm/pgtable.h: In function `ptep_test_and_clear_dirty':
/usr/include/asm/pgtable.h:291: `ptep' undeclared (first use in this 
function)
/usr/include/asm/pgtable.h: At top level:
/usr/include/asm/pgtable.h:292: parse error before '*' token
/usr/include/asm/pgtable.h: In function `ptep_test_and_clear_young':
/usr/include/asm/pgtable.h:292: `ptep' undeclared (first use in this 
function)
/usr/include/asm/pgtable.h: At top level:
/usr/include/asm/pgtable.h:293: parse error before '*' token
/usr/include/asm/pgtable.h: In function `ptep_set_wrprotect':
/usr/include/asm/pgtable.h:293: `ptep' undeclared (first use in this 
function)
/usr/include/asm/pgtable.h: At top level:
/usr/include/asm/pgtable.h:294: parse error before '*' token
/usr/include/asm/pgtable.h: In function `ptep_mkdirty':
/usr/include/asm/pgtable.h:294: `ptep' undeclared (first use in this 
function)
/usr/include/asm/pgtable.h: At top level:
/usr/include/asm/pgtable.h:306: parse error before "pte_modify"
/usr/include/asm/pgtable.h:306: parse error before "pte"
/usr/include/asm/pgtable.h: In function `pte_modify':
/usr/include/asm/pgtable.h:308: `pte' undeclared (first use in this 
function)
/usr/include/asm/pgtable.h:308: `PTE_MASK' undeclared (first use in this 
function)
/usr/include/asm/pgtable.h:309: `newprot' undeclared (first use in this 
function)
In file included from /usr/include/linux/highmem.h:5,
                 from /usr/include/linux/pagemap.h:16,
                 from scripts/kconfig/conf.c:336:
/usr/include/asm/pgalloc.h: At top level:
/usr/include/asm/pgalloc.h:59: parse error before '*' token
/usr/include/asm/pgalloc.h: In function `get_pgd_slow':
/usr/include/asm/pgalloc.h:61: `pgd_t' undeclared (first use in this 
function)
/usr/include/asm/pgalloc.h:61: `pgd' undeclared (first use in this function)
/usr/include/asm/pgalloc.h:61: parse error before ')' token
/usr/include/asm/pgalloc.h:64: `PAGE_OFFSET' undeclared (first use in 
this function)
/usr/include/asm/pgalloc.h: At top level:
/usr/include/asm/pgalloc.h:74: parse error before '*' token
/usr/include/asm/pgalloc.h: In function `get_pgd_fast':
/usr/include/asm/pgalloc.h:84: `pgd_t' undeclared (first use in this 
function)
/usr/include/asm/pgalloc.h:84: parse error before ')' token
/usr/include/asm/pgalloc.h: At top level:
/usr/include/asm/pgalloc.h:87: parse error before '*' token
/usr/include/asm/pgalloc.h: In function `free_pgd_fast':
/usr/include/asm/pgalloc.h:89: `pgd' undeclared (first use in this function)
/usr/include/asm/pgalloc.h: At top level:
/usr/include/asm/pgalloc.h:94: parse error before '*' token
/usr/include/asm/pgalloc.h: In function `free_pgd_slow':
/usr/include/asm/pgalloc.h:103: `pgd' undeclared (first use in this 
function)
/usr/include/asm/pgalloc.h: At top level:
/usr/include/asm/pgalloc.h:107: parse error before '*' token
/usr/include/asm/pgalloc.h: In function `pte_alloc_one':
/usr/include/asm/pgalloc.h:109: `pte_t' undeclared (first use in this 
function)
/usr/include/asm/pgalloc.h:109: `pte' undeclared (first use in this 
function)
/usr/include/asm/pgalloc.h:111: parse error before ')' token
/usr/include/asm/pgalloc.h: At top level:
/usr/include/asm/pgalloc.h:117: parse error before '*' token
/usr/include/asm/pgalloc.h: In function `pte_alloc_one_fast':
/usr/include/asm/pgalloc.h:127: `pte_t' undeclared (first use in this 
function)
/usr/include/asm/pgalloc.h:127: parse error before ')' token
/usr/include/asm/pgalloc.h: At top level:
/usr/include/asm/pgalloc.h:130: parse error before '*' token
/usr/include/asm/pgalloc.h: In function `pte_free_fast':
/usr/include/asm/pgalloc.h:132: `pte' undeclared (first use in this 
function)
/usr/include/asm/pgalloc.h: At top level:
/usr/include/asm/pgalloc.h:137: parse error before '*' token
/usr/include/asm/pgalloc.h: In function `pte_free_slow':
/usr/include/asm/pgalloc.h:139: `pte' undeclared (first use in this 
function)
/usr/include/asm/pgalloc.h: In function `flush_tlb_mm':
/usr/include/asm/pgalloc.h:183: `current' undeclared (first use in this 
function)
/usr/include/asm/pgalloc.h: In function `flush_tlb_page':
/usr/include/asm/pgalloc.h:190: dereferencing pointer to incomplete type
/usr/include/asm/pgalloc.h:190: `current' undeclared (first use in this 
function)
/usr/include/asm/pgalloc.h: In function `flush_tlb_range':
/usr/include/asm/pgalloc.h:197: `current' undeclared (first use in this 
function)
In file included from scripts/kconfig/conf.c:336:
/usr/include/linux/pagemap.h: In function `page_cache_alloc':
/usr/include/linux/pagemap.h:36: dereferencing pointer to incomplete type
/usr/include/linux/pagemap.h: In function `_page_hashfn':
/usr/include/linux/pagemap.h:66: sizeof applied to an incomplete type
/usr/include/linux/pagemap.h:66: sizeof applied to an incomplete type
/usr/include/linux/pagemap.h:66: sizeof applied to an incomplete type
/usr/include/linux/pagemap.h:66: sizeof applied to an incomplete type
/usr/include/linux/pagemap.h: At top level:
/usr/include/linux/pagemap.h:82: parse error before '(' token
/usr/include/linux/pagemap.h:83: parse error before '(' token
scripts/kconfig/conf.c:337:25: linux/mpage.h: No such file or directory
scripts/kconfig/conf.c:341: syntax error before "int"
scripts/kconfig/conf.c:346: parse error before "page_buf_bmap_t"
scripts/kconfig/conf.c:347: warning: `struct inode' declared inside 
parameter list
scripts/kconfig/conf.c:348: warning: function declaration isn't a prototype
scripts/kconfig/conf.c: In function `map_blocks':
scripts/kconfig/conf.c:349: `vnode_t' undeclared (first use in this 
function)
scripts/kconfig/conf.c:349: `vp' undeclared (first use in this function)
scripts/kconfig/conf.c:349: warning: implicit declaration of function 
`LINVFS_GET_VP'
scripts/kconfig/conf.c:349: `inode' undeclared (first use in this function)
scripts/kconfig/conf.c:353: warning: implicit declaration of function 
`VOP_BMAP'
scripts/kconfig/conf.c:353: `offset' undeclared (first use in this function)
scripts/kconfig/conf.c:353: `count' undeclared (first use in this function)
scripts/kconfig/conf.c:353: `flags' undeclared (first use in this function)
scripts/kconfig/conf.c:353: `pbmapp' undeclared (first use in this function)
scripts/kconfig/conf.c:354: `PBF_WRITE' undeclared (first use in this 
function)
scripts/kconfig/conf.c:355: warning: implicit declaration of function 
`unlikely'
scripts/kconfig/conf.c:355: `PBF_DIRECT' undeclared (first use in this 
function)
scripts/kconfig/conf.c:356: `PBMF_DELAY' undeclared (first use in this 
function)
scripts/kconfig/conf.c:357: `PBF_FILE_ALLOCATE' undeclared (first use in 
this function)
scripts/kconfig/conf.c:360: warning: implicit declaration of function 
`VMODIFY'
scripts/kconfig/conf.c:365:1: unterminated comment
scripts/kconfig/conf.c:368:33: warning: no newline at end of file
make[1]: *** [scripts/kconfig/conf.o] Error 1
make: *** [scripts/kconfig/mconf] Error 2


