Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264178AbTH1S3e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 14:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264179AbTH1S3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 14:29:34 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:19346 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S264178AbTH1S3b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 14:29:31 -0400
Message-ID: <3F4E4A78.5020409@namesys.com>
Date: Thu, 28 Aug 2003 22:31:20 +0400
From: Vladimir Demidov <demidov@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021204
X-Accept-Language: en-us, ru
MIME-Version: 1.0
To: Steven Cole <elenstev@mesatop.com>
CC: Oleg Drokin <green@namesys.com>, reiserfs-dev@namesys.com,
       reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: reiser4 snapshot for August 26th.
References: <20030826102233.GA14647@namesys.com> <1061922037.1670.3.camel@spc9.esa.lanl.gov>
In-Reply-To: <1061922037.1670.3.camel@spc9.esa.lanl.gov>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Steven Cole wrote:

|On Tue, 2003-08-26 at 04:22, Oleg Drokin wrote:
|
|>Hello!
|>
|>   I have just released another reiser4 snapshot that I hope all 
interested
|>   parties will try. It is released against 2.6.0-test4.
|>   You can find it at http://namesys.com/snapshots/2003.08.26
|>   I include release notes below.
|>
|>Reiser4 snapshot for 2003.08.26
|>
|
|I got this error while attempting to compile with reiser4.
|Snippet from .config follows.
|
|Steven
|
|  CC      fs/reiser4/plugin/file/tail_conversion.o

befor compile "fs/reiser4/sys_reiser4.o" yacc mast be create 
"fs/reiser4/parser/parser.code.c:"
why it not created?
Is yacc installed on your computer and patched?

|
|  CC      fs/reiser4/sys_reiser4.o
|fs/reiser4/sys_reiser4.c:54:32: parser/parser.code.c: No such file or 
directory
|fs/reiser4/sys_reiser4.c: In function `sys_reiser4':
|fs/reiser4/sys_reiser4.c:75: warning: implicit declaration of function 
`reiser4_pars_init'
|fs/reiser4/sys_reiser4.c:75: warning: assignment makes pointer from 
integer without a cast
|fs/reiser4/sys_reiser4.c:80: error: dereferencing pointer to incomplete 
type
|fs/reiser4/sys_reiser4.c:82: warning: implicit declaration of function 
`yyparse'
|fs/reiser4/sys_reiser4.c:83: warning: implicit declaration of function 
`reiser4_pars_free'
|fs/reiser4/sys_reiser4.c:66: warning: unused variable `Gencode'
|fs/reiser4/sys_reiser4.c: At top level:
|fs/reiser4/parser/parser.h:333: warning: `Fistmsg' defined but not used
|fs/reiser4/parser/parser.h:342: warning: `typesOfCommand' defined but 
not used
|fs/reiser4/parser/parser.h:354: warning: `Code' defined but not used
|make[2]: *** [fs/reiser4/sys_reiser4.o] Error 1
|make[1]: *** [fs/reiser4] Error 2
|make: *** [fs] Error 2
|[steven@spc1 linux-2.6.0-test4-r4]$ grep REISER4 .config
|CONFIG_REISER4_FS=y
|CONFIG_REISER4_FS_SYSCALL=y
|CONFIG_REISER4_LARGE_KEY=y
|# CONFIG_REISER4_CHECK is not set
|CONFIG_REISER4_USE_EFLUSH=y
|# CONFIG_REISER4_BADBLOCKS is not set
|
|
|
|

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/Tkp21LHFcKwUya8RAkPqAKCYI9+/8nAlz/4fOrcTCdz1FfKDpwCeIP3q
aOfMgqqX7Jgo1hM5kVdTcbc=
=rzM5
-----END PGP SIGNATURE-----


