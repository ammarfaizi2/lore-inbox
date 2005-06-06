Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbVFFVkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbVFFVkZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 17:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbVFFVkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 17:40:25 -0400
Received: from web61015.mail.yahoo.com ([209.73.179.24]:42641 "HELO
	web61015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261694AbVFFVkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 17:40:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=jLBY3q9v1SPYItxKzFvOz3f/HqBW1+l0fO+MlmCy6p6ZIe5Sd8cnFBwZTueBny3qZ4c+HnPx0DA5w7PFC8fwFI4FVumsJ3z99zTRzFtMpvTPaZJ+BPhJ5rpbkF9CalbAnuEy0jSl9ym8mMvSo43O7fq/4Nd3UpAssU1vfX6E+ec=  ;
Message-ID: <20050606213957.67191.qmail@web61015.mail.yahoo.com>
Date: Mon, 6 Jun 2005 14:39:57 -0700 (PDT)
From: suse amd <amd64_linux@yahoo.com>
Subject: Memory errors
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A motherboard with a dual opteron processor and each
processor having 1GB and 2GB ram modules gives the
following error when a user runs memory pattern test
program.

Would appreciate some help on how to pinpoint to which
dimm is bad on the CPU1 bank. Physical access to the
machine is not there. 

regards
suse

------

Jun  3 21:55:48 localhost kernel: CPU 1: Silent
Northbridge MCE
Jun  3 21:55:48 localhost kernel: Northbridge status
d447c000e0080a13
Jun  3 21:55:48 localhost kernel:     ECC syndrome
bits e00f
Jun  3 21:55:48 localhost kernel:     extended error
chipkill ecc error
Jun  3 21:55:48 localhost kernel:     link number 0
Jun  3 21:55:48 localhost kernel:     corrected ecc
error
Jun  3 21:55:48 localhost kernel:     error address
valid
Jun  3 21:55:48 localhost kernel:     error enable
Jun  3 21:55:48 localhost kernel:     error overflow
Jun  3 21:55:48 localhost kernel:     previous error
lost
Jun  3 21:55:48 localhost kernel:     error address
00000002359feb20
Jun  4 00:28:46 localhost kernel: CPU 1: Silent
Northbridge MCE
Jun  4 00:28:46 localhost kernel: Northbridge status
d417c000ed080a13
Jun  4 00:28:46 localhost kernel:     ECC syndrome
bits ed2f
Jun  4 00:28:46 localhost kernel:     extended error
chipkill ecc error
Jun  4 00:28:46 localhost kernel:     link number 0
Jun  4 00:28:46 localhost kernel:     corrected ecc
error
Jun  4 00:28:46 localhost kernel:     error address
valid
Jun  4 00:28:46 localhost kernel:     error enable
Jun  4 00:28:46 localhost kernel:     error overflow
Jun  4 00:28:46 localhost kernel:     previous error
lost
Jun  4 00:28:46 localhost kernel:     error address
000000024ef3fd20
Jun  4 01:49:17 localhost kernel: CPU 1: Silent
Northbridge MCE
Jun  4 01:49:17 localhost kernel: Northbridge status
d447c000e0080a13
Jun  4 01:49:17 localhost kernel:     ECC syndrome
bits e00f
Jun  4 01:49:17 localhost kernel:     extended error
chipkill ecc error
Jun  4 01:49:17 localhost kernel:     link number 0
Jun  4 01:49:17 localhost kernel:     corrected ecc
error
Jun  4 01:49:17 localhost kernel:     error address
valid
Jun  4 01:49:17 localhost kernel:     error enable
Jun  4 01:49:17 localhost kernel:     error overflow
Jun  4 01:49:17 localhost kernel:     previous error
lost
Jun  4 01:49:17 localhost kernel:     error address
000000027917fba0
Jun  4 10:44:16 localhost kernel: CPU 1: Silent
Northbridge MCE
Jun  4 10:44:16 localhost kernel: Northbridge status
d447c000e0080a13
Jun  4 10:44:16 localhost kernel:     ECC syndrome
bits e00f
Jun  4 10:44:16 localhost kernel:     extended error
chipkill ecc error
Jun  4 10:44:16 localhost kernel:     link number 0
Jun  4 10:44:16 localhost kernel:     corrected ecc
error
Jun  4 10:44:16 localhost kernel:     error address
valid
Jun  4 10:44:16 localhost kernel:     error enable
Jun  4 10:44:16 localhost kernel:     error overflow
Jun  4 10:44:16 localhost kernel:     previous error
lost
Jun  4 10:44:16 localhost kernel:     error address
000000020dc7e8e0
Jun  6 10:38:11 localhost syslogd 1.4.1: restart.

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
