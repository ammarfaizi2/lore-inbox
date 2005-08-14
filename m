Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbVHNJNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbVHNJNG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 05:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbVHNJNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 05:13:06 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:33940 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932116AbVHNJNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 05:13:04 -0400
From: Grant Coady <Grant.Coady@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: annabellesgarden@yahoo.de, jgarzik@pobox.com
Subject: Resolved?: Via-Rhine NIC, Via SATA or reiserfs broken, how to tell??
Date: Sun, 14 Aug 2005 19:12:48 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <q02uf1dr6bugj88pimkkfsq68saslpcf16@4ax.com>
References: <54nnf1tv8722aq6med3mlr4mvg7nli0r09@4ax.com>
In-Reply-To: <54nnf1tv8722aq6med3mlr4mvg7nli0r09@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Aug 2005 09:43:31 +1000, Grant Coady <Grant.Coady@gmail.com> wrote:

Hi there,

Problem was dataloss on extracting kernel source, sometimes only 
one character changed.  Details on 

  http://bugsplatter.mine.nu/test/boxen/sempro/

Not the NIC, not reiserfs, not the kernel config, not even the 
SATA data cable...  Not make sense :o)

Dataloss seemed to be the buffered memory copy of the tarball, 
but this box also compile several hundred kernels in a session 
without a problem.  It also locked up after 4 1/2 hours compiling, 
at that time I thought a kernel config change fixed the issue.

Solution?

Set BIOS memory timing to manual, thinking perhaps BIOS sometimes 
not read SPD EEPROM correctly, 'cos it was like I had bad memory 
only sometimes, reboot, memory okay, next day maybe something bad 
again.

I'll be extracting source tarballs twice and diff for some time to 
be sure.  Built the box in March, it sometimes locked up, I'd do 
some ad hoc kernel config adjustments and carry on.  This time I try 
to methodically nail the issue and got nowhere with configuration 
changes.

Does BIOS not setting memory timing properly sometimes sound like a 
reasonable explanation for the fault?  Extracted about 100 tarballs 
without error.  Currently running 2.6.13-rc6-git5 which produced 
heaps of errors before I attacked the hardware, reseating memory 
modules, AGP card and adjust the BIOS settings.

Grant.

