Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbUCKMdt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 07:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUCKMdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 07:33:49 -0500
Received: from euw0000232-pip.eu.verio.net ([213.130.50.58]:38409 "EHLO
	euw0000232-pip.eu.verio.net") by vger.kernel.org with ESMTP
	id S261214AbUCKMds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 07:33:48 -0500
Message-ID: <40505CA0.6080702@porism.com>
Date: Thu, 11 Mar 2004 12:33:36 +0000
From: Gerald Krafft <gkrafft@porism.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-gb, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: hanging in wait_for_tcp_memory
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Mar 2004 12:38:10.0625 (UTC) FILETIME=[B6630310:01C40765]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have some database processes (Interbase V6) that occasionally seem to 
hang. Using ps or top I found that they are waiting in 
wait_for_tcp_memory. What exactly does wait_for_tcp_memory do and under 
which circumstances does this function block?
I'm using Red Hat Linux 7.2, kernel version 2.4.7-10smp on a dual 
processor machine. Were there any known problems with 
wait_for_tcp_memory in that kernel version that might have been fixed in 
later versions?

Thanks
Gerald


