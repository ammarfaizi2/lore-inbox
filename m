Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbUEVWFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUEVWFd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 18:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbUEVWFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 18:05:33 -0400
Received: from mx3.cs.washington.edu ([128.208.3.132]:24515 "EHLO
	mx3.cs.washington.edu") by vger.kernel.org with ESMTP
	id S261606AbUEVWF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 18:05:29 -0400
Date: Sat, 22 May 2004 15:05:28 -0700 (PDT)
From: Vadim Lobanov <vadim@cs.washington.edu>
To: linux-kernel@vger.kernel.org
Subject: modprobe_path & hotplug_path
Message-ID: <20040522150054.R26485-100000@attu1.cs.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just wanted to inquire about something curious that I saw in the kernel 
subtree...

Currently modprobe_path and hotplug_path are declared as "char ...[256]", 
though it seems to me (unless I've missed something), that they only ever 
hold "/sbin/modprobe" and "/sbin/hotplug", respectively. Any reason why we 
couldn't simply declare them "char ...[]", and let them be sized 
appropriately?

Let me know if I've missed something.

Thanks,
Vadim Lobanov

