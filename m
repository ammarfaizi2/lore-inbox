Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262967AbTDIQLy (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 12:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263333AbTDIQLy (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 12:11:54 -0400
Received: from web41804.mail.yahoo.com ([66.218.93.138]:37014 "HELO
	web41804.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262967AbTDIQLx (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 12:11:53 -0400
Message-ID: <20030409162328.96601.qmail@web41804.mail.yahoo.com>
Date: Wed, 9 Apr 2003 09:23:28 -0700 (PDT)
From: sample junk <gumnam777@yahoo.com>
Subject: Help needed reg implementation of LDT on i386
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
      I am trying to implement per process LDT for
linux-2.4.20 on IA-32. During booting the kernel
does'nt get past the invocation of /sbin/init.
      I have made the following changes for my
implementation
1) Have added segment descriptors for User code and
data in the newly created segment in the function 
"copy_segments".
2)changed the __USER_CS and USER_DS to point into the
new descriptors created above.

   Could anyone suggest where i  had gone wrong??

TIA
gum

__________________________________________________
Do you Yahoo!?
Yahoo! Platinum - Watch CBS' NCAA March Madness, live on your desktop!
http://platinum.yahoo.com
