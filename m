Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965338AbWHOJtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965338AbWHOJtL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 05:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965340AbWHOJtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 05:49:11 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:21923 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S965338AbWHOJtK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 05:49:10 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Oops on suspend
Date: Tue, 15 Aug 2006 11:53:03 +0200
User-Agent: KMail/1.9.3
Cc: Pavel Machek <pavel@suse.cz>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <1155603152.3948.4.camel@daplas.org>
In-Reply-To: <1155603152.3948.4.camel@daplas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608151153.03441.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 August 2006 02:52, Antonino A. Daplas wrote:
> Anyone see this oops on suspend to disk? Copied by hand only.
> 
> EIP is at swap_type_of
> 
> swsusp_write
> pm_suspend_disk
> enter_state
> state_store
> subsys_attr_store
> sysfs_write_file
> vfs_write
> sys_write
> sysenter_past_EIP
> 
> openSUSE-10.2-Alpha3 (2.6.18-rc4), but I see this also with stock
> 2.6.18-rc4-mm1.

Are there two swap partitions on your system?  Is any of them on an LVM?

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
