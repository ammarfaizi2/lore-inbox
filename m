Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311968AbSCQIkE>; Sun, 17 Mar 2002 03:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311967AbSCQIjz>; Sun, 17 Mar 2002 03:39:55 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13586 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S311965AbSCQIjq>;
	Sun, 17 Mar 2002 03:39:46 -0500
Message-ID: <3C945635.4050101@mandrakesoft.com>
Date: Sun, 17 Mar 2002 03:39:17 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-fsdevel@vger.kernel.org
Subject: fadvise syscall?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anyone ever done an madvise(2)-type syscall for file descriptors?
(or does the capability exist and I'm missing it?)


I was thinking, in playing around with stuff like cp(1) I've found that 
standard read(2) and write(2) of a 4-8K buffer is the fastest solution 
overall, in addition to providing the useful side effect of better error 
reporting, such as ENOSPC report.  Better error reporting than the 
alternative I see anyway, mmap(2).

So... we have madvise, why not fadvise?  I would love the capability for 
applications to provide hints to the OS like madvise, but for file 
descriptors...

    Jeff



