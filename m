Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264495AbUDSP5Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 11:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264494AbUDSP5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 11:57:25 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:34773 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S264495AbUDSP4n convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 11:56:43 -0400
Subject: Re: [PATCH] Clean up asm/pgalloc.h include (s390)
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-390@vm.marist.edu, Linux Kernel List <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OF97AEF891.DC06EC8E-ONC1256E7B.00576CE3-C1256E7B.00578DF9@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Mon, 19 Apr 2004 17:56:19 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 19/04/2004 17:56:21
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





> This patch cleans up needless includes of asm/pgalloc.h from the
> arch/s390/ subtree.  This has not been compile tested, so
> needs the architecture maintainers (or willing volunteers) to
> test.

Doesn't compile. s390_ksyms needs pgalloc.h for the definition of diag10.
The other includes of pgalloc.h can be removed without a problem.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


