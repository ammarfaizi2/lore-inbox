Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbTD0Xa5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 19:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbTD0Xa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 19:30:57 -0400
Received: from 81-1-65-35.homechoice.co.uk ([81.1.65.35]:24081 "HELO
	sc-outsmtp1.homechoice.co.uk") by vger.kernel.org with SMTP
	id S262001AbTD0Xa4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 19:30:56 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Filesystem: vmufs
Date: Mon, 28 Apr 2003 00:43:00 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200304280043.00778.adrian@mcmen.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am writing a filesystem driver for the Sega Dreamcast Virtual Memory Unit 
(vmu) for 2.4 and have:

* Got read (in every way afaics) to work fine
* Added ability to delete files
* Added ability to copy a file on top of an existing file
(see the cvs for the project if you need to know more - follow the link off 
http://linuxdc.net)


But, I cannot work out how to add the ability to, say, mv a file:

mv /somedirectory/ext2file /mnt/vmu/ext2file

or

cp /somedirectory/ext2file /mnt/vmu/ext2file


What calls do I need to implement to ensure that these two command actually 
work (at present they fail reporting that /mnt/vmu/ext2file does not exist).


Sorry to add to the traffic on this list but googling and various newsgroup 
searches have failed to tuen up the answers I need and the souce is very 
complicated.

Adrian McMenamin
adrian@mcmen.demon.co.uk
