Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262209AbULCOpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbULCOpo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 09:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbULCOpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 09:45:43 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:39598 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S262209AbULCOpd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 09:45:33 -0500
Subject: Re: page fault scalability patch V12 [0/7]: Overview and
	performance tests
From: Sebastien Decugis <sebastien.decugis@ext.bull.net>
To: linux-ia64@vger.kernel.org, linux-mm@vger.kernel.org,
       linux-kernel@vger.kernel.org
Organization: Bull S.A.
Date: Fri, 03 Dec 2004 15:49:51 +0100
Message-Id: <1102085391.14792.102.camel@decugiss.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 03/12/2004 15:52:45,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 03/12/2004 15:52:48,
	Serialize complete at 03/12/2004 15:52:48
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Gerrit Huizenga, 2004-12-02 16:24:04]
> Towards that end, there
> was a recent effort at Bull on the NPTL work which serves as a very
> interesting model:

> http://nptl.bullopensource.org/Tests/results/run-browse.php

> Basically, you can compare results from any test run with any other
> and get a summary of differences.  That helps give a quick status
> check and helps you focus on the correct issues when tracking down
> defects.

Thanks Gerrit for mentioning this :)

Just an additional information -- the tool used to get this reporting
system is OSS and can be found here:
http://tslogparser.sourceforge.net

This tool is not mature yet, but it gives an overview of how useful a
test suite can be, when the results are easy to analyse...

It currently supports only the Open POSIX Test Suite, but I'd be happy
to work to enlarge the scope of this tool.

Regards, 
Seb.

PS: please include me in reply as I'm not subscribed to the list...
-------------------------------
Sebastien DECUGIS
NPTL Test & Trace Project
http://nptl.bullopensource.org/

"You may fail if you try.
You -will- fail if you don't."

