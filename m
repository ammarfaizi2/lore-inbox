Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264414AbTLZBCI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 20:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264428AbTLZBCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 20:02:08 -0500
Received: from crisium.vnl.com ([194.46.8.33]:18963 "EHLO crisium.vnl.com")
	by vger.kernel.org with ESMTP id S264414AbTLZBCF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 20:02:05 -0500
Date: Fri, 26 Dec 2003 01:02:04 +0000
From: Dale Amon <amon@vnl.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0 compile failure
Message-ID: <20031226010204.GM4987@vnl.com>
Mail-Followup-To: Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux, the choice of a GNU generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like this is the night for 2.6.0 bug reports!
Here's the output when the build craps out:

fs/smbfs/inode.c: In function `smb_fill_super':
fs/smbfs/inode.c:554: warning: comparison is always false due to limited range of data type
fs/smbfs/inode.c:555: warning: comparison is always false due to limited range of data type
gcc: {standard input}: Assembler messages:
{standard input}:11930: Warning: end of file not at end of a line; newline inserted
{standard input}:12164: Error: invalid character '_' in mnemonic
Internal error: Terminated (program cc1)
Please submit a full bug report.
See <URL:http://gcc.gnu.org/bugs.html> for instructions.
For Debian GNU/Linux specific bugs,
please see /usr/share/doc/debian/bug-reporting.txt.

make[2]: *** [drivers/block/floppy.o] Error 1
make[1]: *** [drivers/block] Error 2
make: *** [drivers] Error 2

I'll probably try building without smbfs. Same
config worked with test11.

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------
