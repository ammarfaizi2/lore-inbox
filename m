Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbUBXSZl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 13:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbUBXSZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 13:25:39 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:49027 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262369AbUBXSZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 13:25:07 -0500
Date: Tue, 24 Feb 2004 19:25:05 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: linux-kernel@vger.kernel.org
Subject: Linux Kernel Cross Compiling Tests [gcc-3.3.3]
Message-ID: <20040224182505.GA25038@MAIL.13thfloor.at>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Folks!

updated my toolchain(s) to gcc-3.3.3 to see if it works and
thought a comparison between the warning/error messages
might be interesting ...

the result: no changes in the compiles/doesn't compile
category for 2.4.25 and 2.6.3, but naturally some changes
in the warnings/errors section ...

from the 20 checked archs:

 alpha, arm, cris, hppa/64, i386, ia64, m68k, mips/64, 
 ppc/64, s390/x, sh/64, sparc/64, v850 and x86_64

only 6 compiled for 2.6.3 and 8 for 2.4.25 with the linux 
kernel default config, for details see:

 http://vserver.13thfloor.at/Stuff/Cross/compile.info

the differences in the output, if somebody is interested
can be found at:

 http://vserver.13thfloor.at/Stuff/Cross/DIFF-2.4.25-gcc3.3.2-gcc3.3.3/
 http://vserver.13thfloor.at/Stuff/Cross/DIFF-2.6.3-gcc3.3.2-gcc3.3.3/

best,
Herbert

PS: gcc-3.3.3 can be compiled with the same patches as 3.3.2

