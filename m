Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbTJKTOp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 15:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbTJKTOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 15:14:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:2946 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263370AbTJKTOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 15:14:45 -0400
Date: Sat, 11 Oct 2003 12:08:52 -0700
From: "David S. Miller" <davem@redhat.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: patches for PROC_FS=n (2.6.0-test7)
Message-Id: <20031011120852.13fa8ec4.davem@redhat.com>
In-Reply-To: <20031010141646.779f10bb.rddunlap@osdl.org>
References: <20031010141646.779f10bb.rddunlap@osdl.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Oct 2003 14:16:46 -0700
"Randy.Dunlap" <rddunlap@osdl.org> wrote:

> http://developer.osdl.org/rddunlap/patches/atmprocfs_260t7.patch

How can this be needed?  When procfs is disabled then
remove_proc_entry() is defined as "do { } while (0)", ie. a nop.
