Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268578AbUJDVYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268578AbUJDVYt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 17:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268588AbUJDVYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 17:24:46 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:26272 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S268589AbUJDVY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 17:24:26 -0400
Message-ID: <4161BF84.9030306@nortelnetworks.com>
Date: Mon, 04 Oct 2004 15:24:20 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: easy question on syscall control flow
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If I drop down from userspace to the kernel to run a syscall, is there any way 
for me to get back to that process' userspace without finishing the syscall (ie 
through signal handlers, etc.)?

I think I'm doing some extra locking that I don't actually need, and I thought 
I'd double-check before removing it.

Thanks,

Chris
