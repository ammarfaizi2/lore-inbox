Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268254AbUJGVOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268254AbUJGVOT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268231AbUJGVNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:13:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:15818 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267890AbUJGUgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 16:36:22 -0400
Date: Thu, 7 Oct 2004 13:39:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: "K.R. Foley" <kr@cybsft.com>
Cc: haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm3 fails to detect aic7xxx
Message-Id: <20041007133956.39c2427e.akpm@osdl.org>
In-Reply-To: <4165A369.60306@cybsft.com>
References: <1097178019.24355.39.camel@localhost>
	<4165A369.60306@cybsft.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"K.R. Foley" <kr@cybsft.com> wrote:
>
> Dave Hansen wrote:
> > I just booted 2.6.9-rc3-mm3 and got the good ol' 
> > 
> > VFS: Cannot open root device "sda2" or unknown-block(0,0)
> > Please append a correct "root=" boot option
> > Kernel panic - not syncing: VFS: Unable to mount root fs on
> > unknown-block(0,0)
> > 
> > backing out bk-scsi.patch seems to fix it.  I believe this worked in
> > 2.6.9-rc3-mm2.
> > 
> > -- Dave
> 
> While I can't verify that backing out bk-scsi.patch fixes it for me yet, 
> I can verify that I get the exact same error trying to boot this kernel. 
> I too am using the aic7xxx.
> 

Were some earlier messages printed out, during the scsi bringup stage?

A full dmesg dump would be nice.
