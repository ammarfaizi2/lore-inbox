Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751485AbWE3MjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbWE3MjT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 08:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWE3MjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 08:39:18 -0400
Received: from web26913.mail.ukl.yahoo.com ([217.146.177.80]:6324 "HELO
	web26913.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751485AbWE3MjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 08:39:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=jPK5p4oDiZaQkFH5vPbuuu92atg6XVGP9oK/Ue1DDbtkR2GhCLaMqV0jJjkKZ9Hj7CxglCpLxA5HALbUAYlwKyN/RG20FZrFpsS+Hj5RUmsMv1hTl/V68OJZaED7K/eFIn0rd4EAolISYiszClpGEwLjdFBLx4kyLjpz50u9K5c=  ;
Message-ID: <20060530123917.3147.qmail@web26913.mail.ukl.yahoo.com>
Date: Tue, 30 May 2006 14:39:16 +0200 (CEST)
From: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Subject: [ANNOUNCE] Gujin PC graphic bootloader version 1.4
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 For people following the bootloading process on ia32.

 Gujin v1.4 is out, correcting all reported bugs, and still
using the 32 bit entry point of the Linux ia32 kernel.

 No big visible changes, but internally it is using more
inter-segment real mode calls so is more easily extended,
and small chages enable better functionalities, like for instance:

 - can simulate El-Torito noemul boot from CDROM _or_ HD partition,
   so that you can copy a bootable CDROM Linux distribution on a
   partition and boot from it (cat /dev/cdrom > /dev/hda8).
 - can read and boot FAT with 2048 bytes per sectors, like when
   creating a FAT16 filesystem on a CDROM (the big block size
   can be interresting for packet writing).
 - recognise FAT16 (and not only FAT12) in tiny.img so this timy.img
   can be install on a USB key to boot directly without menu.
 - can load > 64 Mbytes kernel or initrd
 - when creating a bootable CDROM in no-emulation, you can use -boot-info-table
   without screen garbage displayed and without loss of functionality.

 To install or upgrade, you should read at least the top of install.txt,
mostly if you have SATA drives.

 Home page and screenshoots of Gujin at:
http://gujin.org

 More information for Gujin on Wikipedia:
http://en.wikipedia.org/wiki/Gujin

 Downloads at Sourceforge:
http://sourceforge.net/projects/gujin

 FAQ/HOWTO at sourceforge:
http://sourceforge.net/docman/display_doc.php?docid=1989&group_id=15465

  Have fun,
  Etienne.



	

	
		
___________________________________________________________________________ 
Yahoo! Mail réinvente le mail ! Découvrez le nouveau Yahoo! Mail et son interface révolutionnaire.
http://fr.mail.yahoo.com
