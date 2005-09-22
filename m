Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbVIVI1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbVIVI1l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 04:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbVIVI1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 04:27:41 -0400
Received: from mx1.cdacindia.com ([203.199.132.35]:7556 "HELO
	mailx.cdac.ernet.in") by vger.kernel.org with SMTP id S1751446AbVIVI1k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 04:27:40 -0400
Message-ID: <4332697C.7070409@cdac.in>
Date: Thu, 22 Sep 2005 13:51:16 +0530
From: Karthik Sarangan <karthiks@cdac.in>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: O_DIRECT for block device
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a scsi hdd configured at /dev/sdb.

open("/dev/sdb", O_DIRECT) succeeds.
A 'read' or 'write' returns -1 and errno is EINVAL.

How to read and write data to it? They do not seem to work. I have a 
262144 byte buffer for data transfer.

My kernel is 2.6.9-11 and I use RedHat Enterprise Linux.

