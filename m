Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbUL2LZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbUL2LZQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 06:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbUL2LZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 06:25:16 -0500
Received: from web60606.mail.yahoo.com ([216.109.118.244]:46193 "HELO
	web60606.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261199AbUL2LZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 06:25:10 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=TYe6J/xQa9stXm4jfv4k0347eJpW1+rik7fvYcAU1pW52jB1Y7SF/bsEc/iXWGBZ8nd4FAB/OWr0eTEl9q1bbCTCE6eMm8FzoKmtUzEkQ6aS+TYIzAwEq5qIHX2Eh74Uw0Mv+ductqatYV4CUS2KUCHXYNF0GEZeWjTK6AWNKz4=  ;
Message-ID: <20041229112510.63226.qmail@web60606.mail.yahoo.com>
Date: Wed, 29 Dec 2004 03:25:10 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: System calls effect after booting phase ??
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I intercepted a few system calls pertaining to file
operations like open,close,pipe etc. Now, I
implemented this stuff in a loadable kernel module. I
am collecting some data from it like which process
currently access a pipe,file etc. I have displayed
them using printk. 
  Now, I want to store them in a table. But I want
this operation to be started right after the initial
booting phase itself part of the loading kernel
itself. What should I do to add my module into the
already compiled kernel image just like a standard
kernel module?

Thanks,
selva

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
