Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbWDXUaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbWDXUaX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 16:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWDXUaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 16:30:22 -0400
Received: from iabervon.org ([66.92.72.58]:27664 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751237AbWDXUaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 16:30:21 -0400
Date: Mon, 24 Apr 2006 16:30:36 -0400 (EDT)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Gary Poppitz <poppitzg@iomega.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
In-Reply-To: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>
Message-ID: <Pine.LNX.4.64.0604241620530.6713@iabervon.org>
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2006, Gary Poppitz wrote:

> I have the task of porting an existing file system to Linux. This code is in
> C++ and I have noticed that the Linux kernel has
> made use of C++ keywords and other things that make it incompatible.

You probably want to look into FUSE. C++ isn't going to be supported in 
the kernel, for a variety of reasons, but filesystems don't have to be in 
the kernel these days. FUSE seems to have C++ bindings with templates and 
stuff, too, so it should be an easy task.

	-Daniel
*This .sig left intentionally blank*
