Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264578AbUEVCKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264578AbUEVCKO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 22:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264524AbUEVCHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 22:07:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:51415 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264578AbUEVCGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 22:06:38 -0400
Date: Fri, 21 May 2004 19:06:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Serice <paul@serice.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iso9660 inodes beyond 4GB
Message-Id: <20040521190602.511d188e.akpm@osdl.org>
In-Reply-To: <40AD2F8A.6030306@serice.net>
References: <40AD2F8A.6030306@serice.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Serice <paul@serice.net> wrote:
>
> The ISO 9660 standard allows meta-data to be stored at almost any
> arbitrary byte on the file system.  The current inode scheme uses the
> byte offset as the inode value making it easy to find the underlying
> block and block offset.
> 
> This scheme is subject to obvious integer overflow problems that
> prevents it from being able to reach meta-data beyond the 4GB
> boundary.  Looking back through the archives, this problem was
> anticipated but discounted because mkisofs puts its meta-data near the
> beginning of the file system.

Dumb question: why not simply use a 64-bit type in the inode?

> The patch is about 28K and can be downloaded from the following URL:
> 
>      http://www.serice.net/shunt/linux-2.6.6-isofs.patch

It goes 404.  Please just send the patch directly to the mailing list.
