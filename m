Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbULNQjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbULNQjZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 11:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbULNQjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 11:39:25 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:58280 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261550AbULNQjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 11:39:19 -0500
Message-ID: <41BF1732.6070300@nortelnetworks.com>
Date: Tue, 14 Dec 2004 10:39:14 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: how to add 32/64 compatible ioctls at runtime via module?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm working on a driver for 2.6.

I'd like to be able to load the driver as a module, and have it register for 
various ioctl() calls on a device node (which can be dynamic, so no problem there).

I'm not sure how to go about registering at runtime for 32/64 bit compatibility 
so that I can load a module into a ppc64 kernel, and have 32-bit userspace code 
call those ioctls.

Can anyone give some pointers, or direct me to existing code?

Thanks,

Chris

