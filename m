Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbUL0Tiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUL0Tiz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 14:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbUL0Tiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 14:38:55 -0500
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:12047 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id S261951AbUL0Tix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 14:38:53 -0500
Message-ID: <41D064D0.6050509@transtec.demon.co.uk>
Date: Mon, 27 Dec 2004 19:38:56 +0000
From: AJM <ajm@transtec.demon.co.uk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-gb, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Module Names - Hyphen Converted to Underscore
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have compiled stock (kernel.org) 2.6.3 and 2.6.9 kernels which exhibit 
the following unusual behaviour on module loading: If the kernel module 
has a hyphen in its name, then this appears to be translated into an 
underscore by the kernel, such that, for example after "insmod 3w-xxxx", 
lsmod shows "3w_xxxx", "rmmod 3w-xxxx" fails but "rmmod 3w_xxxx" succeeds.

The distribution I am compiling the kernels under is Mandrake 10.0, and 
if I compile the 2.6.3-4mdk kernel source supplied with the distribution 
  then this problem does not arise.

A Google search reveals a number of similar problems, but with no 
explanation other than possible typing errors.

Any suggestions as to why this is happening?

Thanks in advance,

Jonathan.
