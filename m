Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbUK2KDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbUK2KDR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 05:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbUK2KDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 05:03:17 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:4772 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261646AbUK2KDI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 05:03:08 -0500
Subject: ELSA 0.3 Released
From: Guillaume Thouvenin <Guillaume.Thouvenin@Bull.net>
To: lkml <linux-kernel@vger.kernel.org>,
       elsa-announce <elsa-announce@lists.sourceforge.net>
Cc: Gerrit Huizenga <gh@us.ibm.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       Jay Lan <jlan@engr.sgi.com>, guillaume.thouvenin@bull.net
Date: Mon, 29 Nov 2004 11:03:03 +0100
Message-Id: <1101722583.7466.10.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/11/2004 11:10:14,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/11/2004 11:10:17,
	Serialize complete at 29/11/2004 11:10:17
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
 
    In this version we removed the kernel patch. Instead, we use a LSM
hook to be informed when a process creates a child. We don't know if LSM
is the right framework but, as there is only this solution in the
official Linux kernel tree, we use it.

All informations to download and install ELSA 0.3 are available on the
ELSA website 
 
  http://elsa.sourceforge.net


Every comments and feedbacks are welcome,
Best regards,

 The ELSA Team.

