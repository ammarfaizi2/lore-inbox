Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263639AbTKRPqC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 10:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263662AbTKRPqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 10:46:02 -0500
Received: from ida.rowland.org ([192.131.102.52]:7684 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S263639AbTKRPqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 10:46:00 -0500
Date: Tue, 18 Nov 2003 10:45:57 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Kernel development list <linux-kernel@vger.kernel.org>
Subject: How can a loadable kernel module remove itself?
Message-ID: <Pine.LNX.4.44L0.0311181036590.783-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Say I've got a kernel module that decides its job is done, and it wants to 
unload itself automatically.  Is there any way to do that?  Basically I'm 
looking for the opposite of the request_module() function, except that 
I've already got a pointer to the module in question, i.e., THIS_MODULE.

Thanks,

Alan Stern



