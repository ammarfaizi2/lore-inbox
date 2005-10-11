Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbVJKEp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbVJKEp2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 00:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbVJKEp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 00:45:28 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:13951 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751293AbVJKEp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 00:45:28 -0400
Date: Tue, 11 Oct 2005 13:41:03 +0900 (JST)
Message-Id: <20051011.134103.02441615.hyoshiok@miraclelinux.com>
To: akpm@osdl.org
Cc: noboru.obata.ar@hitachi.com, linux-kernel@vger.kernel.org,
       hyoshiok@miraclelinux.com
Subject: Re: Linux Kernel Dump Summit 2005
From: Hiro Yoshioka <hyoshiok@miraclelinux.com>
In-Reply-To: <20051010174931.223310de.akpm@osdl.org>
References: <20050921.205550.927509530.hyoshiok@miraclelinux.com>
	<20051006.211718.74749573.noboru.obata.ar@hitachi.com>
	<20051010174931.223310de.akpm@osdl.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.13 (Rational FORTRAN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

From: Andrew Morton <akpm@osdl.org>
> OBATA Noboru <noboru.obata.ar@hitachi.com> wrote:
> >
> > > We had a Linux Kernel Dump Summit 2005.
> 
> I was rather expecting that the various groups which are interested in
> crash dumping would converge around kdump once it was merged.  But it seems
> that this is not the case and that work continues on other strategies.

My impression is that most of crash dump developers would like
to converge kexec/kdump approach. However they are developing
dump tools.

The reasons are
1) They have to maintain the dump tools and support their users.
   Many users are still using 2.4 kernels so merging kdump into 2.6
   kernel does not help them.
2) Commercial Linux Distros (Red Hat/Suse/MIRACLE(Asianux)/Turbo etc) use
   LKCD/diskdump/netdump etc.
   Almost no users use a vanilla kernel so kdump does not have users yet.

> Is that a correct impression?  If so, what shortcoming(s) in kdump are
> causing people to be reluctant to use it?

I think the way to go is the kdump however it may take time.

Regards,
  Hiro
