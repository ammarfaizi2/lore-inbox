Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264415AbRFXT0b>; Sun, 24 Jun 2001 15:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264418AbRFXT0W>; Sun, 24 Jun 2001 15:26:22 -0400
Received: from mail6.speakeasy.net ([216.254.0.206]:48135 "HELO
	mail6.speakeasy.net") by vger.kernel.org with SMTP
	id <S264415AbRFXT0K>; Sun, 24 Jun 2001 15:26:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: linux-kernel@vger.kernel.org
Subject: ide-scsi detecting CDR as "CD-ROM" in 2.2.19
Date: Sun, 24 Jun 2001 15:26:07 -0400
X-Mailer: KMail [version 1.2.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010624192618Z264415-17721+5482@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using the ide patch "ide.2.2.19.05042001" for 2.2.19.   In 2.4.5 this cdr 
wsa detected as a cdr.  here it's detected as:
  Vendor: CREATIVE  Model:  CD-RW RW8438E    Rev: FC03
  Type:   CD-ROM                             ANSI SCSI revision: 02


Cdrecord says this.
cdrecord: Invalid argument. Cannot get mmap for 4198400 Bytes on /dev/zero.
TOC Type: 1 = CD-ROM

How do i make it be detected as a cdrw or at least cdr?
