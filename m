Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268399AbTCFVem>; Thu, 6 Mar 2003 16:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268402AbTCFVem>; Thu, 6 Mar 2003 16:34:42 -0500
Received: from gtwy.nap.wideopenwest.com ([64.233.207.11]:43042 "EHLO
	pop-1.dnv.wideopenwest.com") by vger.kernel.org with ESMTP
	id <S268399AbTCFVel>; Thu, 6 Mar 2003 16:34:41 -0500
From: kelleycook@wideopenwest.com
Reply-to: kelleycook@wideopenwest.com
To: linux-kernel@vger.kernel.org
Subject: Disabling ATAPI retry?
X-Mailer: WebMAIL to Mail Gateway v3.0h
Date: Thu, 06 Mar 2003 15:58:51 -0500
Message-id: <3e67c49b.7c12.1804289383@wideopenwest.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am attempting to copy data off a damaged partition on an
ATAPI hard drive onto a new drive using 'dd
conv=sync,noerror' since my Deskstar recently blew up.

My main problem is the fact that when it hits a bad sector,
the drive goes into retry mode for a sizeable portion of
time before coming back with an error.  This means that as a
rough estimate, it is going to take a month to copy the
partition.

Is there a boot parameter or a runtime command that can tell
the linux IDE driver not to automatically retry on error.

Sorry if this is an FAQ, but I could not find the
information.

Kelley Cook
