Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264668AbUJLO0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbUJLO0y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 10:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264098AbUJLOZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 10:25:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23011 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264386AbUJLOYD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 10:24:03 -0400
Date: Mon, 11 Oct 2004 08:39:42 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Can Sar <csar@stanford.edu>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Page/Buffer Cache: Traversing Dirty Buffers
Message-ID: <20041011113942.GC417@logos.cnet>
References: <C6322819-1B77-11D9-8CAE-000393B3D4EC@stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C6322819-1B77-11D9-8CAE-000393B3D4EC@stanford.edu>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 04:22:02AM -0700, Can Sar wrote:
> Hi,
> 
> I know this is not really the right place for asking general questions, 
> but I have read the source and searched the web and LKML archives for 2 
> days without much avail.
> I am writing a driver for a research project, and need to be able to 
> traverse all dirty buffers in the buffer cache, for this device. I have 
> read through buffer.c and several other files a dozen times, but have 
> not been able to pin down exactly how to get access to the buffer 
> cache. If someone could point any files that I should look at, to get a 
> pointer to all the dirty buffers associated with a device, I would be 
> very happy.
> 
> Thank you very much for your help,
> Can Sar

What kernel version are you using? 

Look at fs/buffer.c sync_buffers() & related functions.
