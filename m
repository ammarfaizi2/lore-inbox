Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269286AbUIYIv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269286AbUIYIv5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 04:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269287AbUIYIv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 04:51:57 -0400
Received: from colin2.muc.de ([193.149.48.15]:61702 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S269286AbUIYIv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 04:51:56 -0400
Date: 25 Sep 2004 10:51:55 +0200
Date: Sat, 25 Sep 2004 10:51:55 +0200
From: Andi Kleen <ak@muc.de>
To: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [Patch] no exec: i386 and x86_64 fixes
Message-ID: <20040925085155.GA97641@muc.de>
References: <20040924154644.B25742@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040924154644.B25742@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 03:46:44PM -0700, Suresh Siddha wrote:
> Appended patch fixes
> 
> a) a bug in i386 which has to do with a typo
> (change elf_read_implies_exec_binary to elf_read_implies_exec)
> 
> b) sync x86_64 noexec behaviour with i386. And remove all the confusing
> noexec related boot parameters.

Thanks, x86-64 part looks good.
-Andi
