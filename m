Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbTJNUtT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 16:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbTJNUtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 16:49:04 -0400
Received: from ms-smtp-05.texas.rr.com ([24.93.36.233]:36043 "EHLO
	ms-smtp-05.texas.rr.com") by vger.kernel.org with ESMTP
	id S261670AbTJNUtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 16:49:00 -0400
Date: Tue, 14 Oct 2003 15:48:50 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@dell.com>
X-X-Sender: mdomsch@iguana.domsch.com
To: torvalds@osdl.org
cc: greg@kroah.com, <linux-kernel@vger.kernel.org>
Subject: [PATCH][BUGFIX] edd.c raw_data file shouldn't hexdump
Message-ID: <Pine.LNX.4.44.0310141546370.16018-100000@iguana.domsch.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GregKH requested this, the kernel shouldn't have code to perform a hexdump.

Linus, please do a

	bk pull http://mdomsch.bkbits.net/linux-2.5-edd

This will update the following files:

 arch/i386/kernel/edd.c |  182 +++++++------------------------------------------
 1 files changed, 29 insertions(+), 153 deletions(-)

through these ChangeSets:

<Matt_Domsch@dell.com> (03/10/12 1.1337.8.1)
   EDD: reads to raw_data return binary data, not hexdump
   
   by request of gregkh
   other minor cleanups


Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

