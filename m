Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272261AbRH3PIn>; Thu, 30 Aug 2001 11:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272260AbRH3PId>; Thu, 30 Aug 2001 11:08:33 -0400
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:22929 "EHLO
	sj-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S272256AbRH3PIZ>; Thu, 30 Aug 2001 11:08:25 -0400
Message-ID: <3B8E5791.5BBE92A2@cisco.com>
Date: Thu, 30 Aug 2001 20:41:13 +0530
From: Venkatesh Ramachandran <rvenky@cisco.com>
Organization: Cisco Systems India Pvt. Ltd., Bangalore, INDIA
X-Mailer: Mozilla 4.61 [en]C-CCK-MCD   (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-users@cisco.com, rvenky@cisco.com, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, brussels-linux@cisco.com
CC: Mathangi Kuppusamy <mathangi@cisco.com>
Subject: Linux Mounting problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
   I am using Redhat Linux 7.1
   During reboot, i get the message " Mounting / as readonly"
   And, it enters into maintenance mode...( & all other steps fail -
/proc not mounted, swap not mounted, fsck fails)
   I did the following :
   mount -t proc proc /proc
   fsck /dev/hda1
   The following error messages : ERROR : Couldn't open /dev/null
(Read-only file system)

   It goes into a never-ending loop, and never i am able to recover from
this problem.

   Has anyone come across such a problem? How to tackle it?
   Do we need to use a bootdisk, to get into the read-write mode of root
filesystem ?
   How to change root filesystem from read-only to read-write?

   This will be of very great help to me and my team.

Thanks in advance,
Venkatesh.

