Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263679AbUD0CKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbUD0CKG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 22:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263686AbUD0CKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 22:10:05 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:57830 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263679AbUD0CKC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 22:10:02 -0400
Date: Mon, 26 Apr 2004 19:08:40 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: hugepagetlb, include linux/module.h
Message-Id: <20040426190840.7e1cb2ec.pj@sgi.com>
In-Reply-To: <20040426164822.46bc97cc.pj@sgi.com>
References: <20040426164822.46bc97cc.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once I hack around the bssprot patch damage to the routine
arch/ia64/ia32/binfmt_elf32.c: elf32_map(), then this patch to remove
#include of module.h from arch/ia64/mm/hugetlbpage.c compiles ok against
2.6.6-rc2-mm2.

As expected.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
