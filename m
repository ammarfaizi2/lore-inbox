Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbTISWIf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 18:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbTISWIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 18:08:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:4830 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261753AbTISWIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 18:08:34 -0400
Message-Id: <200309192208.h8JM8WH26535@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: 2.6.0-test5 - powermac compile problem "incorrect section attributes 
 for .plt"
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 19 Sep 2003 15:08:32 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



System is an iBook2,
distro is Debian unstable
kernel is 2.6.0-test5 or current from
bk://ppc.bkbits.net/linuxppc-2.5

gcc version 3.3.2 20030908 (Debian prerelease)

When compiling modules, i get this warning, repeatedly:
 CC [M]  sound/ppc/pmac.o
{standard input}: Assembler messages:
{standard input}:3: Warning: setting incorrect section attributes for .plt

Then, this failure:

  AS      arch/ppc/boot/common//util.o
arch/ppc/boot/common/util.S: Assembler messages:
arch/ppc/boot/common/util.S:220: Warning: setting incorrect section attributes 
for .relocate_code
arch/ppc/boot/common//util.o: File truncated
arch/ppc/boot/common/util.S:281: FATAL: Can't write 
arch/ppc/boot/common//util.o: File truncated
make[2]: *** [arch/ppc/boot/common//util.o] Error 1
make[1]: *** [arch/ppc/boot/common/] Error 2

Suggestions appreciated.
cliffw



