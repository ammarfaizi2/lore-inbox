Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbUCaDEo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 22:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUCaDEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 22:04:43 -0500
Received: from corpmail.outblaze.com ([203.86.166.82]:7049 "EHLO
	corpmail.outblaze.com") by vger.kernel.org with ESMTP
	id S261355AbUCaDEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 22:04:42 -0500
Date: Wed, 31 Mar 2004 11:04:39 +0800
From: Yusuf Goolamabbas <yusufg@outblaze.com>
To: linux-kernel@vger.kernel.org
Subject: Strange output from exportfs in 2.6.5-rc3-mm1
Message-ID: <20040331030439.GA23306@outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.11; VAE: 6.24.0.7; VDF: 6.24.0.76; host: corpmail.outblaze.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6.5-rc3-mm1, I saw the following via dmesg

exportfs: no version for "init_module" found: kernel tainted.

I am exporting a few filesystems via NFS but this is the first 2.6.x
kernel in which I have seen the above message
Output of lsmod

nfsd                   94344  - 
exportfs                5440  - 
lockd                  59912  - 
sunrpc                134312  - 
e100                   28196  - 
ext3                  116104  - 
jbd                    55416  - 
aic7xxx               164588  - 
sd_mod                 17696  - 
scsi_mod              109200  - 

Regards, Yusuf
