Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVBGRYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVBGRYK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 12:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVBGRYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 12:24:08 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:905 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261199AbVBGRV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 12:21:29 -0500
Message-ID: <4207A395.1060901@nortel.com>
Date: Mon, 07 Feb 2005 11:21:25 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: where to export system tuneables, /proc/sys/kernel or /sys/?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm doing some kernel work that will export tuneables to userspace.  In 
2.4 I would have used /proc/sys/kernel, but now there is /sys, which was 
supposed to be for system information.

However, a bit of poking around in /sys didn't reveal any obvious place 
to put it.  Is current practice to still put this sort of thing in /proc?

Thanks,

Chris
