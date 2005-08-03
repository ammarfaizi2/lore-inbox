Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVHCX27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVHCX27 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 19:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVHCX2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 19:28:54 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:25737 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id S261634AbVHCX2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 19:28:44 -0400
Message-ID: <42F15326.6000402@nortel.com>
Date: Wed, 03 Aug 2005 17:28:38 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: question on memory map of process on i386
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On i386, /proc/<pid>/maps shows the following entry:

ffffe000-fffff000 ---p 00000000 00:00 0

This page of memory is way up above TASK_SIZE (which is 0xc0000000), so 
how is it visible to userspace?

Just to complicate things,  I seem to find the vma for this page using 
find_vma_prev().

Can anyone explain what's going on?



Thanks,

Chris
