Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbTDNDrL (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 23:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbTDNDrL (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 23:47:11 -0400
Received: from [195.60.21.2] ([195.60.21.2]:48571 "EHLO pluto.fastfreenet.com")
	by vger.kernel.org with ESMTP id S262731AbTDNDrL (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 23:47:11 -0400
Message-ID: <002101c30239$fc0ae630$fe64a8c0@webserver>
From: "Bryan Shumsky" <bzs@via.com>
To: <linux-kernel@vger.kernel.org>
Subject: Memory mapped files question
Date: Sun, 13 Apr 2003 20:57:34 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, everyone.  I'm running into a problem that I hope someone else has seen,
and maybe can help solve.  We're using the mmap system function for memory
mapped files, but our updates never get flushed until we munmap or msysnc.
Are we missing something?  Is there a tunable parameter in the kernel or
filing system that can be set to flag these updates as 'write required'?

Any advice or suggestions would be appreciated.

Regards,

-- Bryan Shumsky
Director of Engineering
Via Systems, Inc.


