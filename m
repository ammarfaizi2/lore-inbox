Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272271AbTG3VZa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 17:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272272AbTG3VZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 17:25:30 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:29396 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S272271AbTG3VZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 17:25:25 -0400
Subject: Question about 2.4 kernel clone() system call for ppc64 64bit apps
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 6.0 September 26, 2002
Message-ID: <OFC831735B.3B4F29F1-ON85256D73.0074B760-86256D73.0075AE54@pok.ibm.com>
From: "Robert Williamson" <robbiew@us.ibm.com>
Date: Wed, 30 Jul 2003 16:24:55 -0500
X-MIMETrack: Serialize by Router on D01ML076/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 07/30/2003 05:25:22 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to get the LTP clone() tests to execute on ppc64 in 64bit mode,
but I keep getting weird SIGSEGVs....even when the test reports PASS.  I've
been able to execute every test in 32bit mode without problems.  Has anyone
successfully used the clone() system call in a 64bit ppc64 app? And if so,
could you PLEASE enlighten me on what I may be doing wrong.  I've attached
one of the LTP clone tests, clone02, which returns PASS, but also gets a
SIGSEGV and has a non-zero return code.....which gets logged as a FAIL.

-Robbie
(Not subscribed to list so please cc my address)

Robert V. Williamson <robbiew@us.ibm.com>
Linux Test Project
IBM Linux Technology Center
Web: http://ltp.sourceforge.net
IRC: #ltp on freenode.irc.net
====================
"Only two things are infinite, the universe and human stupidity, and I'm
not sure about the former." -Albert Einstein


