Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317597AbSHHOzE>; Thu, 8 Aug 2002 10:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317598AbSHHOzE>; Thu, 8 Aug 2002 10:55:04 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:28110 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317597AbSHHOzD>;
	Thu, 8 Aug 2002 10:55:03 -0400
Date: Thu, 08 Aug 2002 09:58:13 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.30+] Second attempt at a shared credentials patch
Message-ID: <23130000.1028818693@baldur.austin.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch allows tasks to share credentials via a flag to clone().

This version fixes the problem with exec() that Linus found.  Tasks that
call exec() get their own copy of the credentials at that point.

The URL is here because it's too big to include in email:

http://www.ibm.com/linux/ltc/patches/misc/cred-2.5.30-3.diff.gz

The patch is against Linus' BK tree as of this morning.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

