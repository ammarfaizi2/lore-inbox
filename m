Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319396AbSIFVXw>; Fri, 6 Sep 2002 17:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319401AbSIFVXw>; Fri, 6 Sep 2002 17:23:52 -0400
Received: from magic.adaptec.com ([208.236.45.80]:3294 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id <S319396AbSIFVXv>;
	Fri, 6 Sep 2002 17:23:51 -0400
Message-ID: <268DBFF7D2A3D411A37400D0B72E345F8990B3@aimexc03.corp.adaptec.com>
From: "Gibson, Chuck" <Chuck_Gibson@adaptec.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Newbie kernel buffer question
Date: Fri, 6 Sep 2002 14:28:22 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am new to Linux (but not kernel development) and am developing a
kernel-mode driver
that needs to read/write a raw disk device.  I have been unable to find a
way to map a
kernel buffer for use with block_read() and/or block_write().
Are there alternate calls to block_read/write that will allow use of a
kernel-mode buffer,
or can it be done with MMAP?  I am considering a temp hack of having a user
process
do an OPEN on my device and pass a user-space buffer to me for my use.  Note
that
the driver does NOT use the normal driver interface, but is an autonomous
driver.

Thanks for any help!

________________
Chuck Gibson
Principal Engineer
Corporate Technology Group
Adaptec, Inc.
(408) 957-2084
cgibson@corp.adaptec.com

