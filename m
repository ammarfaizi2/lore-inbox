Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263018AbTJPO7X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 10:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbTJPO7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 10:59:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:42728 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263018AbTJPO7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 10:59:21 -0400
Date: Thu, 16 Oct 2003 07:58:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steven Pratt <slpratt@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: 2.6.0-test7-mm1
Message-Id: <20031016075815.266e5c4b.akpm@osdl.org>
In-Reply-To: <3F8EAEB5.5040102@austin.ibm.com>
References: <3F8EAEB5.5040102@austin.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Pratt <slpratt@austin.ibm.com> wrote:
>
> On reboot after heavy IO loads (tiobench) I keep getting the following 
>  oops.

Yup.  The "invalidate_inodes-speedup-fixes" and "invalidate_inodes-speedup"
patches were not so great and need to be reverted.

