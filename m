Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbUFSApq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbUFSApq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 20:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265649AbUFSAnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 20:43:22 -0400
Received: from web10904.mail.yahoo.com ([216.136.131.40]:13595 "HELO
	web10904.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265537AbUFSAhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 20:37:19 -0400
Message-ID: <20040619003712.35865.qmail@web10904.mail.yahoo.com>
Date: Fri, 18 Jun 2004 17:37:12 -0700 (PDT)
From: Ashwin Rao <ashwin_s_rao@yahoo.com>
Subject: Atomic operation for physically moving a page
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I want to copy a page from one physical location to
another (taking the appr. locks). To keep the
operation of copying and updation of all ptes and
caches atomic one way proposed by my team members was
to sleep the processes accessing the page.
ptep_to_mm gives us the mm_struct but container_of
cannot help to get to task_struct as it contains a
mm_struct pointer. Is there any way of identifying the
proccess's from the pte_entry.
Is there any way out to solve my original problem  of
keeping the whole operation of copying and updation
atomic as this is a bad solution for real time
processes but is there any other way out.

Ashwin



		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
http://promotions.yahoo.com/new_mail 
