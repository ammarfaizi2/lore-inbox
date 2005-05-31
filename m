Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVEaSbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVEaSbp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 14:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVEaSbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 14:31:40 -0400
Received: from mail.dvmed.net ([216.237.124.58]:11138 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261171AbVEaSbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 14:31:33 -0400
Message-ID: <429CAD7B.5070301@pobox.com>
Date: Tue, 31 May 2005 14:31:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Waitz <tali@admingilde.org>
CC: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: DocBook build failures, and graphical figures
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some DocBook-related comments and questions:

* "make psdocs" and "make pdfdocs" both fail in current tree, on Fedora 
Core 2 (FC2) and Red Hat Enterprise Linux 4 (RHEL4).  Strangely enough, 
they fail on different files.  I've attached output-psdocs.txt and 
output-pdfdocs.txt showing the errors I get.

Both psdocs and pdfdocs -do- work for some files.  Each target proceeds 
for a bit, and then finds a specific file it doesn't like, and dies. 
100% reproducible.

In each failing case, I can use "db2ps" or "db2pdf" to successfully 
convert the XML file, whereas xmlto fails.


* Can you make it easy to change the paper size to something custom, 
like 6x9in ?


* Is there an example somewhere describing how to insert graphics 
(figures and charts) ?


Regards and thanks,

	Jeff




