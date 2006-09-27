Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965328AbWI0FKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965328AbWI0FKe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 01:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965330AbWI0FKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 01:10:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63901 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965328AbWI0FKc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 01:10:32 -0400
Date: Tue, 26 Sep 2006 22:10:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
Subject: Re: Stupid kexec/kdump question...
Message-Id: <20060926221029.d9e87650.akpm@osdl.org>
In-Reply-To: <200609261525.k8QFP6j4022389@turing-police.cc.vt.edu>
References: <200609261525.k8QFP6j4022389@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2006 11:25:06 -0400
Valdis.Kletnieks@vt.edu wrote:

> OK, I'm running a Fedora Core 6 (rawhide actually) box with -18-mm1 kernel.
> I've installed kexec-tools and similar, and am trying to get the kernels
> built following the hints in Documentation/kdump/kdump.txt, but a few
> questions arise:
> 
> 1) Other than the fact that the Fedora userspace looks for a ${kernelvers}kdump
> kernel, is there any reason the kdump kernel has to match the running one, or
> can an older kernel be used?
> 
> 2) I'm presuming that a massively stripped down kernel (no sound support,
> no netfilter, no etc) that just has what's needed to mount the dump location
> is sufficient?
> 
> 3) The docs recommend 'crashkernel=64M@16M', but that's 8% of my memory.
> What will happen if I try '16M@16M' instead?  Just slower copying due to
> a smaller buffer cache space, or something more evil?
> 

(cc added)
