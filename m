Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270359AbRHSLkb>; Sun, 19 Aug 2001 07:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270354AbRHSLkV>; Sun, 19 Aug 2001 07:40:21 -0400
Received: from red.csi.cam.ac.uk ([131.111.8.70]:19378 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S270366AbRHSLkS>;
	Sun, 19 Aug 2001 07:40:18 -0400
Message-Id: <5.1.0.14.2.20010819123911.00add7d0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 19 Aug 2001 12:40:32 +0100
To: Juergen Rose <rose@rz.uni-potsdam.de>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Can't compile ntfs modules with 2.4.9
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B7F9D0A.3070805@rz.uni-potsdam.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The correct solution is to edit fs/ntfs/unistr.c and to add:

#include <linux/kernel.h>

to the other includes at the top of the file.

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

