Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268406AbUIWLVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268406AbUIWLVI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 07:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268407AbUIWLVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 07:21:08 -0400
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:14795 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268406AbUIWLVA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 07:21:00 -0400
Subject: Re: Windows Logical Disk Manager error
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Marcin =?iso-8859-2?Q?Gibu=B3a?= <mg@iceni.pl>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200409231254.12287@senat>
References: <200409231254.12287@senat>
Content-Type: text/plain; charset=UTF-8
Organization: University of Cambridge Computing Service, UK
Message-Id: <1095938455.22371.41.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 23 Sep 2004 12:20:56 +0100
Content-Transfer-Encoding: 8BIT
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-23 at 11:54, Marcin Gibuła wrote:
> while using a disc partitioned with ldm the following error occures:
> 
> sda:<6>ldm_validate_vmdb(): VMDB and TOCBLOCK don't agree on the database 
> size.
> [LDM] sda1 sda2 sda3 sda4

Can you compile in ldm debugging support and then send the full debug
output at boot time?

Also can you download the ldm tools
(http://linux-ntfs.sourceforge.net/downloads.html) and copy the ldm
database to a file and make it available to me?

To dump the database do:

download linux-ldm-0.0.8.tar.bz2 then:

tar xvjf linux-ldm-0.0.8.tar.bz2
cd linux-ldm-0.0.8/test
./ldminfo --copy /dev/sda
tar cvjf ldmdump.tar.bz2 sda.data sda.part

The created file ldmdump.tar.bz2 is what we need.

Thanks in advance.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

