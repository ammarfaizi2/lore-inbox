Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbULTBre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbULTBre (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 20:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbULTBre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 20:47:34 -0500
Received: from [211.58.254.17] ([211.58.254.17]:38039 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S261377AbULTBrc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 20:47:32 -0500
Date: Mon, 20 Dec 2004 10:47:28 +0900
From: Tejun Heo <tj@home-tj.org>
To: greg@kroah.com, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [PATCH REPOST 2.6.10-rc3 0/4] module sysfs: module sysfs related cleanups
Message-ID: <20041220014728.GA16197@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Greg.

 Here are the regenerated patches with the fix.

01_mkobj_inline.patch
        Make module.mkobj inline.  As this is simpler and what's
        usually done with kobjs when it's representing an entity.

02_module_attribute_extension.patch
        Modify module_attribute show/store methods to accept self
        argument to enable further extensions.

03_module_sections_attr_grp.patch
        Reimplement section attributes using attribute group.  This
        makes more sense, for, while they reside in a separate
        subdirectory, they belong to the ownig module and their
        lifetime exactly equals the lifetime of the owning module,
        and it's simpler.

04_module_paramters_attr_grp.patch
        Reimplement parameter attributes using attribute group.
	This makes more sense, for, while they reside in a separate
        subdirectory, they belong to the ownig module and their
        lifetime exactly equals the lifetime of the owning module,
        and it's simpler.

 Thanks.

-- 
tejun
