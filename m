Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263733AbUD0DuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263733AbUD0DuM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 23:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbUD0DuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 23:50:12 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:47871 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263733AbUD0DuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 23:50:10 -0400
Date: Mon, 26 Apr 2004 20:49:01 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: hugepagetlb, include linux/module.h
Message-Id: <20040426204901.0d5a49e3.pj@sgi.com>
In-Reply-To: <20040426164822.46bc97cc.pj@sgi.com>
References: <20040426164822.46bc97cc.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And with a couple more hacks (kill ffb_drv.c for lack of PCI IDS,
and random clueless hubstatus variable rename in drivers/usb/core/hub.c),
this removal of #include of linux/module.h compiles for sparc64 as well.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
