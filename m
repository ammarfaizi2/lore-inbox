Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269908AbUJTU7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269908AbUJTU7j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 16:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270563AbUJTUyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 16:54:18 -0400
Received: from out010pub.verizon.net ([206.46.170.133]:44497 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S270564AbUJTUvs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 16:51:48 -0400
Message-ID: <4176CFE3.2030306@verizon.net>
Date: Wed, 20 Oct 2004 16:51:47 -0400
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC] Structural changes for Documentation directory
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [209.158.211.53] at Wed, 20 Oct 2004 15:51:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I propose changing the structure of the Documentation directory to 
reflect the structure of the kernel sources itself.

How I see it working is: (Excuse the ASCII-art)

Documentation/
    |
    |____ arch/
    |      |
    |      |____ i386/
    |      |
    |      |____ s390/
    |      |
    |      |____ (etc.)
    |
    |____ drivers/
    |      |
    |      |____ cdrom/
    |      |
    |      |____ serial/
    |      |
    |      |____ (etc.)
    |
    |____ net/
    |      |
    |      |____ sunrpc/
    |      |
    |      |____ atm/
    |      |
    |      |____ (etc.)
    |
    |____ kernel/
    |
    |____ mm/

With the files that have no real home in the source (SubmittingPatches, 
CodingStyle, kernel-docs.txt, etc) to remain in the main directory.

Perhaps it would be best to put the new tree in place and have the 
individual maintainers relocate their documentation to the new 
structure?  This would also be a good way to find out what files are 
orphaned, and are in need of update or removal.

Comments?  Additions?  Warnings?
