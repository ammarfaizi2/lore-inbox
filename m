Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbVHWHoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbVHWHoV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 03:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbVHWHoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 03:44:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16035 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750844AbVHWHoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 03:44:21 -0400
Date: Tue, 23 Aug 2005 00:42:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [proposal] remove struct file *file from aops
Message-Id: <20050823004251.3e728391.akpm@osdl.org>
In-Reply-To: <2cd57c90050823001855403664@mail.gmail.com>
References: <2cd57c90050823001855403664@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt <coywolf@gmail.com> wrote:
>
> Hello,
> 
> The argument struct file *file in aops { .readpage, .readpages,
> prepare_write, .commit_wirte } is not used.  I'd like to file a series
> of patches to clean it up. Are there any other concerns?

NFS uses it in readpage().
