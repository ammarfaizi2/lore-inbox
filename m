Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272522AbRIKSzr>; Tue, 11 Sep 2001 14:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272527AbRIKSzh>; Tue, 11 Sep 2001 14:55:37 -0400
Received: from mail.cdlsystems.com ([207.228.116.20]:23567 "EHLO
	cdlsystems.com") by vger.kernel.org with ESMTP id <S272522AbRIKSz2>;
	Tue, 11 Sep 2001 14:55:28 -0400
Message-ID: <006a01c13af3$5b917d90$160e10ac@hades>
From: "Mark Cuss" <mcuss@cdlsystems.com>
To: <linux-kernel@vger.kernel.org>
Subject: Lost files on Filesystem - 2.4.9
Date: Tue, 11 Sep 2001 12:55:42 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Return-Path: mcuss@cdlsystems.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: mcuss@cdlsystems.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I posted a message regarding this problem about a month or so ago, and am
now seeing it more frequently.  On two different machines (one being a
single processor "standard" PC running 2.4.3, and the other being our
server:  A dual SMP 1 GHz with 4 SCSI disks, paired into 2 software striping
RAIDs (RAID 0) ).

The problem is that changes that people make to the filesystem don't seem to
"stick".  An example:  A user makes changes and his/her files with their
editor.  The backup runs that night and captures the changes (backups are
run on a Windows 2000 Server running Backup Exec with a Unix Backup Agent
installed on the Linux server).  When the user returns the next day, the
files have reverted to a previous state.  Looking at the backup shows that
the changes *were* present on the filesystem, but have since vanished.  I
have checked all the kernel logs and found nothing.  The machine did not go
down on either occasion.  A previous poster mentioned problems with bdflush
not running - I have checked and it does seem to be running OK.  If anyone
would like more information about the machines' configuration please let me
know.

Thanks in advance for your help,

Mark

Mark Cuss, B. Sc.
Junior Real Time Systems Analyst
CDL Systems Ltd
3553 - 31 Street NW
Calgary, Alberta
(403) 289-1733 ext 226
mcuss@cdlsystems.com


