Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbUE1LrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbUE1LrV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 07:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbUE1LrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 07:47:20 -0400
Received: from 217-162-68-113.dclient.hispeed.ch ([217.162.68.113]:25737 "EHLO
	steudten.com") by vger.kernel.org with ESMTP id S261685AbUE1LrP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 07:47:15 -0400
Message-ID: <40B726C0.5030400@steudten.com>
Date: Fri, 28 May 2004 13:47:12 +0200
From: Thomas Steudten <alpha@steudten.com>
Organization: STEUDTEN ENGINEERING
MIME-Version: 1.0
To: linux-admin@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-alpha@vger.kernel.org
Subject: Kernel crash/ oops >= 2.6.5 with gcc 3.4.0 on alpha
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: Mailer
X-Check: 2c1783c72b2809387bfafaa1e08e3128
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Sorry, maybe I miss some message before.

I build the 2.6.6 kernel with gcc-3.4.0 and it crashs after
start some init scripts (got no log at this time).
So I tried to rebuild my last build 2.6.5, and this
crashs to. The build with gcc-3.3.3 works without problems.
modutils-2.4.27

http://www.uwsg.iu.edu/hypermail/linux/kernel/0405.1/1532.html

No other application seems to fail with gcc-3.4.0 so I think
this problem is in context to the relocation, modules and gcc-3.4.0.

make modules
make[1]: `arch/alpha/kernel/asm-offsets.s' is up to date.
   CC [M]  fs/binfmt_em86.o
{standard input}: Assembler messages:
{standard input}:7: Warning: setting incorrect section attributes for .got
   CC [M]  fs/quota_v2.o
{standard input}: Assembler messages:
{standard input}:7: Warning: setting incorrect section attributes for .got
   CC [M]  fs/autofs/dirhash.o
   CC [M]  fs/autofs/init.o
{standard input}: Assembler messages:
{standard input}:7: Warning: setting incorrect section attributes for .got
   CC [M]  fs/autofs/inode.o


On x86 everything works without problems.

Please CC me.
-- 
Tom

LINUX user since kernel 0.99.x 1994.
RPM Alpha packages at http://alpha.steudten.com/packages
Want to know what S.u.S.E 1995 cdrom-set contains?



