Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265527AbSJXQUO>; Thu, 24 Oct 2002 12:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265528AbSJXQUO>; Thu, 24 Oct 2002 12:20:14 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:11259 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265527AbSJXQUN>;
	Thu, 24 Oct 2002 12:20:13 -0400
Importance: Normal
Sensitivity: 
Subject: Switching from IOCTLs to a RAMFS
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFE3B65375.45D5B484-ON85256C5C.005A3AF2@pok.ibm.com>
From: "Mark Peloquin" <peloquin@us.ibm.com>
Date: Thu, 24 Oct 2002 11:23:23 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11  |July 29, 2002) at
 10/24/2002 12:26:19 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Based on the feedback and comments regarding
the use of IOCTLs in EVMS, we are switching to
the more preferred method of using a ram based
fs. Since we are going through this effort, I
would like to get it right now, rather than
having to switch to another ramfs system later
on. The question I have is:  should we roll our
own fs, (a.k.a. evmsfs) or should we use sysfs
for this purpose? My initial thoughts are that
sysfs should be used. However, recent discussions
about device mapper have suggested a custom ramfs.
Which is the *best* choice?

Thanks,
Mark



