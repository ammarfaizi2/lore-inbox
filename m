Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266049AbUGTR3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266049AbUGTR3X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 13:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266063AbUGTR3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 13:29:23 -0400
Received: from w130.z209220038.sjc-ca.dsl.cnc.net ([209.220.38.130]:63214 "EHLO
	mail.inostor.com") by vger.kernel.org with ESMTP id S266049AbUGTR3T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 13:29:19 -0400
Message-ID: <40FD561D.1010404@inostor.com>
Date: Tue, 20 Jul 2004 10:27:57 -0700
From: Shesha Sreenivasamurthy <shesha@inostor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'kernelnewbies@nl.linux.org'" <kernelnewbies@nl.linux.org>
Subject: O_DIRECT
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having trouble with O_DIRECT. Trying to read or write from a block 
device partition.

1. Can O_DIRECT be used on a plain block device partition say 
"/dev/sda11" without having a filesystem on it.

2. If no file system is created then what should be the softblock size. 
I am using the IOCTL "BLKBSZGET". Is this correct?

3. Can we use SEEK_END with O_DIRECT on a partition without filesystem.

Any help will be highly regarded.

-Shesha


