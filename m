Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWICVMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWICVMM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 17:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWICVMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 17:12:12 -0400
Received: from pat.uio.no ([129.240.10.4]:34294 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932160AbWICVML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 17:12:11 -0400
Subject: Re: in-kernel rpc.statd
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0609032255010.6844@yvahk01.tjqt.qr>
References: <20060903180052.GA3743@pc51072.physik.uni-regensburg.de>
	 <Pine.LNX.4.61.0609032255010.6844@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Sun, 03 Sep 2006 17:11:55 -0400
Message-Id: <1157317915.5587.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.055, required 12,
	autolearn=disabled, AWL 1.95, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-03 at 23:01 +0200, Jan Engelhardt wrote:
> >I'd like to ask if someone is maintaining a patchset, that implements
> >the in-kernel rpc.statd (as found in SuSE kernels). I tried to fiddle
> >some patches of Suse-10.1 into 2.6.17, but failed, unfortunately.
> 
> Hm. I do not have a rpc.statd userspace program nor kernel daemon (running 
> on 2.6.17-vanilla). Yet everything is working. Is there a specific need for 
> statd?

Yes. Locking over NFSv2/v3 won't work without it.

That said, there is no reason why we need an rpc.statd in the kernel
when the nfs-utils package already provides one that works fine in
userland.

Cheers,
  Trond


-- 
VGER BF report: H 2.2074e-05
