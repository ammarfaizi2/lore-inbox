Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbUKHMqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbUKHMqf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 07:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbUKHMqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 07:46:35 -0500
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:62346 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S261832AbUKHMqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 07:46:32 -0500
Subject: Elsa 0.2 Released
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Reply-To: guillaume.thouvenin@bull.net
To: lkml <linux-kernel@vger.kernel.org>
Message-Id: <1099917982.6477.44.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 08 Nov 2004 13:46:22 +0100
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 08/11/2004 13:53:10,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 08/11/2004 13:53:13,
	Serialize complete at 08/11/2004 13:53:13
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

ELSA is an Enhanced Linux System Accounting. We propose a user space
solution (except a small modification of 4 lines in the Linux kernel) 
for managing groups of processes and providing a per-job accounting 
instead of the classical per-process accounting. Work can be split into 
the following parts :

     1. A kernel patch (4 lines in fork.c)
     2. A kernel module
     3. A user space daemon
     4. Per-process accounting informations (external like 
        BSD-accounting)
     5. A user space application

In this release, we improve the user space application. We provide an
environment (ncurses) to manage the group of processes and we also
provide an analyzer that computes per-job accounting. The analyzer is
able to parse BSD accounting informations and it can also parse 
informations about jobs provided by the job daemon. With such 
informations, we can provide per-job accounting. A sample session is 
available (with some screen shots) at:
http://elsa.sourceforge.net/sample_session.html

All informations to download ELSA 0.2 are available on the main web page:
http://elsa.sourceforge.net

Every comments are welcome,
The ELSA Team.

