Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbUCGFWP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 00:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbUCGFWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 00:22:15 -0500
Received: from mailgate2.mysql.com ([213.136.52.47]:47757 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S261752AbUCGFWO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 00:22:14 -0500
Subject: Any way to access huge pages ?
From: Peter Zaitsev <peter@mysql.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: MySQL
Message-Id: <1078636886.2313.718.camel@abyss.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 06 Mar 2004 21:21:28 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm wondering is there any way to access "large pages" (4MB) memory
other than using shared memory ?  For example can you do anonymous mmap
to get access to large pages. 

I would like to utilize large pages for MySQL buffer pool and other
large caches, but would not like to use Shared memory for this purpose 
as it will complicate things for users. 


-- 
Peter Zaitsev, Senior Support Engineer
MySQL AB, www.mysql.com

Meet the MySQL Team at User Conference 2004! (April 14-16, Orlando,FL)
  http://www.mysql.com/uc2004/

