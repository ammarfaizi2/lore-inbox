Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261409AbSLaLAk>; Tue, 31 Dec 2002 06:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261456AbSLaLAk>; Tue, 31 Dec 2002 06:00:40 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:9638 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261409AbSLaLAj> convert rfc822-to-8bit; Tue, 31 Dec 2002 06:00:39 -0500
Message-Id: <4.3.2.7.2.20021231114848.00b5ada0@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 31 Dec 2002 11:58:59 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Re: [PATCHSET] 2.4.21-pre2-jp15
Cc: joergprante@netcologne.de
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jörg,
	Here is the patch for the wan/comx problem.

--- linux-2.4.20/fs/proc/root.c 2002-12-29 17:54:33.000000000 +0100
+++ linux-2.4.20mw0/fs/proc/root.c      2002-12-31 11:45:21.000000000 +0100
@@ -158,3 +158,4 @@
  EXPORT_SYMBOL(proc_net);
  EXPORT_SYMBOL(proc_bus);
  EXPORT_SYMBOL(proc_root_driver);
+EXPORT_SYMBOL(proc_get_inode);

	Margit 

