Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262269AbSJLIds>; Sat, 12 Oct 2002 04:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262393AbSJLIds>; Sat, 12 Oct 2002 04:33:48 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:23437 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262269AbSJLIdr>;
	Sat, 12 Oct 2002 04:33:47 -0400
Importance: Normal
Sensitivity: 
Subject: Re: "duplicate const" compile warning in 2.5.42
To: Reuben Farrelly <reuben-linux@reub.net>
Cc: linux-kernel@vger.kernel.org, anton@samba.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF38E5DBB6.1DFD70C1-ON87256C50.002E73F2@boulder.ibm.com>
From: "Steven French" <sfrench@us.ibm.com>
Date: Sat, 12 Oct 2002 03:38:52 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 10/12/2002 02:38:55 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Reuben,
The "duplicate const" compile warning you mention seems to be a minor
problem with the min/max macros.

The fix for the 64 bit warnings for the cifs vfs are not going to affect
the duplicate const minor warning caused by the min/max macro.  This
warning does not show up on my i386 2.5.41 builds.



Steve French
Senior Software Engineer
Linux Technology Center - IBM Austin
phone: 512-838-2294
email: sfrench@us.ibm.com


