Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbULQPBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbULQPBS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 10:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbULQPBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 10:01:17 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:23501 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261240AbULQPA4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 10:00:56 -0500
Subject: ELSA 0.4 Released
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: guillaume.thouvenin@bull.net,
       elsa-announce <elsa-announce@lists.sourceforge.net>,
       elsa-devel <elsa-devel@lists.sourceforge.net>
Date: Fri, 17 Dec 2004 16:00:49 +0100
Message-Id: <1103295649.7329.78.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 17/12/2004 16:08:24,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 17/12/2004 16:08:26,
	Serialize complete at 17/12/2004 16:08:26
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

    ELSA is an Enhanced Linux System Accounting. We propose a solution
for managing groups of processes without kernel modifications. We
provide a per-job accounting instead of the classical per-process
accounting. Work can be split into the following parts :

     1. A LSM hook
     2. A kernel module
     3. A user space daemon
     4. Per-process accounting informations (external like
        BSD-accounting)
     5. A user space application

ChangeLog:

    In this version we add support for several job for a given process.
Until now, a process only belongs to one given job. This is too
restrictive. For example, if you want to do accounting for all ssh
sessions, you add the main ssh daemon in a job and like that, all
connections are added and accounting can be done. The problem occurs if
you also want to do accounting inside a session. As the session's pid is
already in a job, you can not add it in another job. ELSA 0.4 removes
this major problem.

    We also submit the fork historic module for reviewing. We hope to
integrate it into the -mm tree.

    All informations to download and install ELSA 0.4 are available on
the ELSA website

  http://elsa.sourceforge.net


Every comments, feedbacks and suggestions are welcome,
Best regards,

 The ELSA Team.

