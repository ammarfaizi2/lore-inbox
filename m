Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424078AbWKIPza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424078AbWKIPza (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 10:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424077AbWKIPz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 10:55:29 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:49311 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1424078AbWKIPz2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 10:55:28 -0500
Subject: [PATCH -mm 0/3][AIO] - AIO completion signal notification
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>, Zach Brown <zach.brown@oracle.com>,
       Dave Jones <davej@redhat.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       "moi @ Bull" <sebastien.dugue@bull.net>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
Date: Thu, 09 Nov 2006 16:55:17 +0100
Message-Id: <1163087717.3879.34.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 09/11/2006 17:02:13,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 09/11/2006 17:02:15,
	Serialize complete at 09/11/2006 17:02:15
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hi

  Here is the latest rework of the AIO completion signal notification patches.

  This set consists in 3 patches:

	1. aio-header-fix-includes: fixes the double inclusion of uio.h in aio.h

	2. export-good_sigevent: move good_sigevent into signal.c and export it

	3. aio-notify-sig: the AIO completion signal notification

  Description are in the individual patches.

  Comments are welcome as usual.

  Thanks,

  Sébastien.

