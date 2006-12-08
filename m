Return-Path: <linux-kernel-owner+w=401wt.eu-S1425988AbWLHRVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425988AbWLHRVJ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 12:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1426037AbWLHRVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 12:21:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:31787 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425988AbWLHRVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 12:21:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=BAtywSJE0w1MeP7VaFNAUghzPFZdL36RgJFcBn266pXtlb2H3mHS4LAyCFLEac9XRAcT+4pjHa5w2OzG4vrOAn0jucF+9oEfhQxyIx8IsFjqPNVzcdb6Z5yjYEGZUroGHMMuhu9oyKKk/95fAJ57TdQnjnBKWD3QLXCLmocF0jI=
Message-ID: <3c698a820612080921u20a957d9x1ac1e01e6734d025@mail.gmail.com>
Date: Fri, 8 Dec 2006 12:21:04 -0500
From: "Maria Short" <mgolod@ieee.org>
To: linux-kernel@vger.kernel.org
Subject: Linux slack space question
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: 9771b153b2158226
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a question regarding how the Linux kernel handles slack space.
I know that the ext3 filesystems typically use 1,2 or 4 KB blocks and
if a file is not an even multiple of the block size then the last
allocated block will not be completely filled, the remaining space is
wasted as slack space.

What I need is the code in the kernel that does that. I have been
looking at http://lxr.linux.no/source/fs/ext3/inode.c but I could not
find the specific code for partially filling the last block and
placing an EOF at the end, leaving the rest to slack space.

Please forward the answer to mgolod@ieee.org as soon as possible.

Thank you very much.
