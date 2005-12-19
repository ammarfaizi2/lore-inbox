Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbVLSVi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbVLSVi5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 16:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbVLSVi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 16:38:57 -0500
Received: from cheetah.cs.fiu.edu ([131.94.130.107]:42113 "EHLO
	cheetah.cs.fiu.edu") by vger.kernel.org with ESMTP id S932254AbVLSVi4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 16:38:56 -0500
Message-ID: <43A7286F.3080104@cs.fiu.edu>
Date: Mon, 19 Dec 2005 16:38:55 -0500
From: John F Flynn III <flynnj@cs.fiu.edu>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Very rare crash in prune_dcache
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good evening, folks...

We have been experiencing a very rare (on average once every two to 
three months) crash on some of our servers.

uname -a:
Linux cheetah 2.6.9-22.0.1.ELsmp #1 SMP Thu Oct 27 13:14:25 CDT 2005 
i686 i686 i386 GNU/Linux

(This is a CentOS provided kernel)

Here is a photo of the bottom of the panic. Unfortunately the kernel has 
no chance to log this anywhere else:

http://www.cs.fiu.edu/~flynnj/cheetah-crash.jpg


The crash appears to be in prune_dcache, and has happened on several 
distinct machines, so we do not believe it is a hardware problem.

If anyone has pointers on what bug could be causing this crash, or if 
it's been fixed in newer kernels we could try, it would be greatly 
appreciated. This only seems to happen on loaded production machines, 
and it happens so rarely that more detailed debugging is nearly impossible.

Thanks in advance,
-John Flynn

-- 
John Flynn                              flynnj@cs.fiu.edu
=========================================================
Systems and Network Administration             /\_/\
School of Computer Science                    ( O.O )
Florida International University               >   <
