Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268392AbUJGVVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268392AbUJGVVV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268404AbUJGVTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:19:46 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:60119 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S267777AbUJGVGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 17:06:19 -0400
Message-ID: <4165AFBC.8010605@nortelnetworks.com>
Date: Thu, 07 Oct 2004 15:06:04 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: george@mvista.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: question about linux time change
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have been asked to add the ability to notify userspace when the time of day 
changes.  The actual notification is the easy part.  I'm having issues with 
where exactly the time is really changed.

do_settimeofday() is pretty straightforward.  No problems there.
adjtimex() with ADJ_OFFSET_SINGLESHOT mode seems reasonable as well.

adjtimex() with ADJ_OFFSET is a bit harder to follow.  Can you give me any 
pointers on what's going on with ADJ_OFFSET?

Thanks,

Chris
