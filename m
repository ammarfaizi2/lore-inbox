Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbTE2UN6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 16:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbTE2UN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 16:13:58 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:30900 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262633AbTE2UN4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 16:13:56 -0400
Message-ID: <3ED66C83.8070608@austin.ibm.com>
Date: Thu, 29 May 2003 15:24:35 -0500
From: Mark Peloquin <peloquin@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Nightly regression runs against current bk tree
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Our team would like to assist the community in quickly identifying 
patches that provide
performance improvements or regressions in the 2.5 kernel tree. The way 
to do this
will be to run a nightly regression test suite against the current bk 
tree, and then compare
the results against the previous night's results, showing the 
differences. Additionally,
also comparing against the 2.5 point release.

We have dedicated a machine and thrown together some scripts that will grab
and build the latest kernel files, execute the regression suite, 
collecting (hopefully)
enough system state information to allow meaningful analysis of any peculiar
results encountered.

Here are links to the current regression results obtained:

2.5.70 vs 2.5.70-bk1:
http://www.ibm.com/developerworks/oss/linuxperf/regression/2.5.70-bk1/2.5.70-vs-2.5.70-bk1/

2.5.70 vs 2.5.70-bk2:
http://www.ibm.com/developerworks/oss/linuxperf/regression/2.5.70-bk2/2.5.70-vs-2.5.70-bk2/
2.5.70-bk1 vs 2.5.70-bk2
http://www.ibm.com/developerworks/oss/linuxperf/regression/2.5.70-bk2/2.5.70-bk1-vs-2.5.70-bk2/

The regression suite executes in about 7.5 hours currently. We would 
like to keep
the execution time below 12 hours, so when a problem is encountered, we 
will have
time to recover without falling behind on the daily snapshots. We have 
attempted
to strike a balance between test execution time and test coverage. Work 
is still
ongoing in the area to provide the best balance and maintain repeatability.

Currently the regression suite operates on the 2.5 kernel bk tree. We do 
plan on
adding another machine that will perform similiar regression comparisons 
for the
-mm and -mjb patches.

Please bear in mind this is work in progress and there might be a few 
rough edges.
However, with your input, we feel it can provide a useful function. 
Please do not
hesitate to provide feedback or suggestions on improvements including 
content
and presentation.

Mark Peloquin
IBM Linux performance team

