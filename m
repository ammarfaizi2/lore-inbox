Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312254AbSFXLGf>; Mon, 24 Jun 2002 07:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312498AbSFXLGe>; Mon, 24 Jun 2002 07:06:34 -0400
Received: from zamok.crans.org ([138.231.136.6]:49581 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id <S312254AbSFXLGd>;
	Mon, 24 Jun 2002 07:06:33 -0400
Date: Mon, 24 Jun 2002 13:06:35 +0200
To: Qin Tao <qtao@cisunix.unh.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel taint
Message-ID: <20020624110635.GA9504@darwin.crans.org>
References: <Pine.OSF.4.44.0206231524160.455830-100000@hypatia.unh.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.44.0206231524160.455830-100000@hypatia.unh.edu>
User-Agent: Mutt/1.4i
X-Warning: Email may contain unsmilyfied humor and/or satire.
From: Vincent Hanquez <tab@crans.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 23, 2002 at 03:37:47PM -0400, Qin Tao wrote:
> Hi,
> 
> I am using redhat7.3 (kernel 2.4.18-3). When I tried to insert a
> kernel module, I got the following warning message:
> 
> "Warning: loading mymodule.o will taint the kernel: forced load"
> 
> I didn't see this problem when I inserted the module to some earlier
> version kernels, such as 2.4.15. Does anybody know what does the warning
> message mean and how can I modify my module code to avoid that?
> 
> Thanks in advance.

I think you can add : MODULE_LICENSE("GPL"); to avoid to taint the
kernel.

you can find others license in the linux source code.
Restrictive licence or unknown license may taint the kernel too.

-- 
Tab
