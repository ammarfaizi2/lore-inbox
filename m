Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262885AbTDIHG4 (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 03:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbTDIHG4 (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 03:06:56 -0400
Received: from [195.60.21.2] ([195.60.21.2]:52136 "EHLO pluto.fastfreenet.com")
	by vger.kernel.org with ESMTP id S262883AbTDIHGy (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 03:06:54 -0400
Message-ID: <007601c2fecd$12209070$230110ac@kaws>
From: "Keith Ansell" <keitha@edp.fastfreenet.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: bdflush flushing memory mapped pages. 
Date: Wed, 9 Apr 2003 20:20:18 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

help

My application uses SHARED memory mapping files for file I/O, and we have
observed
that Linux does not flush dirty pages to disk until munmap or msync are
called.

I would like to know are there any development plans which would address
this issue or
if there is a version of bdflush which flushes write required pages (dirty
pages) to disk?

Regards
        Keith Ansell.


