Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbVKAVa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbVKAVa1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 16:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbVKAVa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 16:30:27 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:40608 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751256AbVKAVa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 16:30:27 -0500
Date: Tue, 1 Nov 2005 16:30:26 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Setting kernel data breakpoints on x86
Message-ID: <Pine.LNX.4.44L0.0511011625280.4473-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to debug a rather difficult data-overwriting problem, and it 
would be a big help to be able to use a data breakpoint.

Is there any easy way of doing this?  I'd prefer not to use a kernel 
debugger, because the address of the breakpoint and the time when it's 
needed are determined dynamically.

Does anybody have a little lightweight procedure for setting one of the 
x86's debug registers to point to a particular location in kernel memory 
space?  I don't care if the whole system crashes when the debug exception 
occurs, just so long as I can get a stack trace and find out where the 
overwrite comes from.

Alan Stern

