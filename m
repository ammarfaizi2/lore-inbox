Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbUDOWIt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 18:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262920AbUDOWIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 18:08:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:38623 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262547AbUDOWIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 18:08:47 -0400
Date: Thu, 15 Apr 2004 15:10:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: maneesh@in.ibm.com, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [PATCH] back out sysfs reference count change
Message-Id: <20040415151059.1136058e.akpm@osdl.org>
In-Reply-To: <20040415213600.GD13578@kroah.com>
References: <20040402043814.GA6993@in.ibm.com>
	<Pine.LNX.4.44L0.0404021629210.889-100000@ida.rowland.org>
	<20040406101320.GB1270@in.ibm.com>
	<20040414132015.GD5422@in.ibm.com>
	<20040415213600.GD13578@kroah.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> This patch looks sane, Andrew, can you let it sit in your -mm tree for a
> while to see if anything breaks with it?

It needs work to make it live alongside ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mm6/broken-out/sysfs-d_fsdata-race-fix-2.patch

What are we doing with sysfs-d_fsdata-race-fix-2 btw?


