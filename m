Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263109AbVCKBtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263109AbVCKBtb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 20:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263000AbVCKBtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 20:49:31 -0500
Received: from fire.osdl.org ([65.172.181.4]:4016 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263112AbVCKBsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 20:48:25 -0500
Date: Thu, 10 Mar 2005 17:47:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: inode cache, dentry cache, buffer heads usage
Message-Id: <20050310174751.522c5420.akpm@osdl.org>
In-Reply-To: <1110394558.24286.203.camel@dyn318077bld.beaverton.ibm.com>
References: <1110394558.24286.203.camel@dyn318077bld.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> So, why is these slab cache are not getting purged/shrinked even
>  under memory pressure ? (I have seen lowmem as low as 6MB). What
>  can I do to keep the machine healthy ?

Tried increasing /proc/sys/vm/vfs_cache_pressure?  (That might not be in
2.6.8 though).

