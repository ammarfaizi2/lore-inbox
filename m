Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262504AbUDAFuY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 00:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbUDAFuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 00:50:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:28610 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262504AbUDAFuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 00:50:20 -0500
Date: Wed, 31 Mar 2004 21:44:17 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: yusufg@outblaze.com, linux-kernel@vger.kernel.org
Subject: Re: Strange output from exportfs in 2.6.5-rc3-mm1
Message-Id: <20040331214417.41ea2635.rddunlap@osdl.org>
In-Reply-To: <20040331213902.147036f3.akpm@osdl.org>
References: <20040331030439.GA23306@outblaze.com>
	<20040331144031.360c2c3f.rddunlap@osdl.org>
	<20040331213902.147036f3.akpm@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2004 21:39:02 -0800 Andrew Morton <akpm@osdl.org> wrote:

| "Randy.Dunlap" <rddunlap@osdl.org> wrote:
| >
| > On Wed, 31 Mar 2004 11:04:39 +0800 Yusuf Goolamabbas wrote:
| > 
| >  | In 2.6.5-rc3-mm1, I saw the following via dmesg
| >  | 
| >  | exportfs: no version for "init_module" found: kernel tainted.
| >  | 
| >  | I am exporting a few filesystems via NFS but this is the first 2.6.x
| >  | kernel in which I have seen the above message
| >  | Output of lsmod
| >  | 
| >  | nfsd                   94344  - 
| >  | exportfs                5440  - 
| >  | lockd                  59912  - 
| >  | sunrpc                134312  - 
| >  | e100                   28196  - 
| >  | ext3                  116104  - 
| >  | jbd                    55416  - 
| >  | aic7xxx               164588  - 
| >  | sd_mod                 17696  - 
| >  | scsi_mod              109200  - 
| > 
| >  I can't reproduce that with 2.6.5-rc3-mm3 (but there are no
| >  changes to exportfs in -mm3).
| 
| You probably didn't have modversions enabled?

Not the first time; I did the second time, but when I booted,
it rebooted for me during early init (repeatable).  :(
(P4 2-proc)  Then I went home.  I can look into this more
tomorrow... or is this a known issue?

| Rusty sent me this:

OK.

--
~Randy
