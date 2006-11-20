Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934175AbWKTORH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934175AbWKTORH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 09:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934177AbWKTORG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 09:17:06 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:62920 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S934175AbWKTORF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 09:17:05 -0500
Date: Mon, 20 Nov 2006 15:17:00 +0100
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Zach Brown <zach.brown@oracle.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       Ulrich Drepper <drepper@redhat.com>
Subject: [PATCH -mm 0/4][AIO] - AIO completion signal notification v2
Message-ID: <20061120151700.4a4f9407@frecb000686>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/11/2006 15:24:04,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/11/2006 15:24:06,
	Serialize complete at 20/11/2006 15:24:06
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



  Hi

  Here is the latest rework of the AIO completion signal notification patches.

  This set consists in 4 patches:

	1. aio-header-fix-includes: fixes the double inclusion of uio.h in aio.h

	2. export-good_sigevent: move good_sigevent into signal.c and export it

	3. aio-notify-sig: the AIO completion signal notification

	4. listio: adds listio support

  Description are in the individual patches.


  Changes from v1:
	- cleanups suggested by Christoph Hellwig, Badari Pulavarty and Zach Brown
	- added lisio patch


  Comments are welcome as usual.

  Thanks,

  Sébastien.

