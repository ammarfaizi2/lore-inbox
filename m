Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbUCaWns (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 17:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbUCaWns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 17:43:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:41091 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261832AbUCaWnq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 17:43:46 -0500
Date: Wed, 31 Mar 2004 14:40:31 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Yusuf Goolamabbas <yusufg@outblaze.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange output from exportfs in 2.6.5-rc3-mm1
Message-Id: <20040331144031.360c2c3f.rddunlap@osdl.org>
In-Reply-To: <20040331030439.GA23306@outblaze.com>
References: <20040331030439.GA23306@outblaze.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2004 11:04:39 +0800 Yusuf Goolamabbas wrote:

| In 2.6.5-rc3-mm1, I saw the following via dmesg
| 
| exportfs: no version for "init_module" found: kernel tainted.
| 
| I am exporting a few filesystems via NFS but this is the first 2.6.x
| kernel in which I have seen the above message
| Output of lsmod
| 
| nfsd                   94344  - 
| exportfs                5440  - 
| lockd                  59912  - 
| sunrpc                134312  - 
| e100                   28196  - 
| ext3                  116104  - 
| jbd                    55416  - 
| aic7xxx               164588  - 
| sd_mod                 17696  - 
| scsi_mod              109200  - 

I can't reproduce that with 2.6.5-rc3-mm3 (but there are no
changes to exportfs in -mm3).  Please send your kernel .config file.

--
~Randy
"You can't do anything without having to do something else first."
-- Belefant's Law
