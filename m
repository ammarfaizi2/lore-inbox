Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265319AbUFHVMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265319AbUFHVMJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 17:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265316AbUFHVMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 17:12:09 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:11021 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S265323AbUFHVME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 17:12:04 -0400
Message-ID: <40C62F2F.4090801@techsource.com>
Date: Tue, 08 Jun 2004 17:27:11 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Increasing number of inodes after format?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was involved in a discussion a while back where it was explained that 
ext2/3 allocate a certain maximum number of inodes at format time, and 
you cannot increase that number later.

It was also mentioned that one or more of the journaling file systems 
(XFS, JFS, Reiser, etc.) either dynamically allocated inodes or could 
increase the maximum later if the pre-allocated set got used up.

Could someone please repeat for me which filesystems have dynamic 
maximum inode counts?

Thanks.

