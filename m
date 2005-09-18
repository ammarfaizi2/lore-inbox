Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbVIRPiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbVIRPiZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 11:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbVIRPiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 11:38:25 -0400
Received: from web54513.mail.yahoo.com ([206.190.49.163]:15220 "HELO
	web54513.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932104AbVIRPiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 11:38:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=No4fQsvUsgLJKj35Bl1uJLLIWijHMKL/HsgOf0SC42GDHKFqC7v9miLlXqpyUwOlWds3AgJAGHM8H5tta8KkgQUvQ4lhbUKXSnir1ngUf9izszeCQvuBRV/5Fzn1SfPxCtCYD4vDErT1ZP0X+LQRihMRFcvyAn2yPqu9OJljKIg=  ;
Message-ID: <20050918153818.42941.qmail@web54513.mail.yahoo.com>
Date: Sun, 18 Sep 2005 08:38:18 -0700 (PDT)
From: Timur <blackdir@yahoo.com>
Subject: Sis695 southbridge support (Asus K8S-MX)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is the first time for me to write to the list so I
hope that I'll be forgiven if I'm not as precise as I
should (I'm definitely not a kernel hacker).

My current motherboard (Asus K8S-MX) uses SiS 695
chipset for southbridge to provide also a SATA/RAID
controller. To my understanding, current kernel does
not support this chipset and for this reason SiS
provides a GPL driver 
(http://www.sis.com/download/download_step2.php?id=155881&agree=1&country=Canada&Image7911.x=67&Image7911.y=8)
which need to be compiled and loaded in order to
access to sata disks. According to SiS, the driver is
designed for kernel 2.6.10 or higher, so my question
is: would it be possible to include it in one of next
kernel releases so that people don't have to recompile
it each time they upgrade the kernel?

Thanks a lot,
blackdir

Note: for those who might be interested, the
motherboard has also a separated IDE controller but
this is already properly recognized in 2.6.10 and used
by the sis5513 module.


		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
