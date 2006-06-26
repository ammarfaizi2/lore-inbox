Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWFZU6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWFZU6i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 16:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWFZU6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 16:58:38 -0400
Received: from pat.uio.no ([129.240.10.4]:38572 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932132AbWFZU6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 16:58:37 -0400
Subject: Re: NFS and partitioned md
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Martin Filip <bugtraq@smoula.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1151355145.4460.16.camel@archon.smoula-in.net>
References: <1151355145.4460.16.camel@archon.smoula-in.net>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 16:58:29 -0400
Message-Id: <1151355509.9797.7.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.814, required 12,
	autolearn=disabled, AWL 1.19, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-26 at 22:52 +0200, Martin Filip wrote:
> Hello to LKML,
> 
> few days ago I've changed my sw RAID5 to use md_d devices, which are
> "partitonable". (major 254, minor dependant on partiton no)
> 
> The problem is with kernel space NFS daemon. When I create loopback
> device and export it - everything works OK, but when exported directory
> is directly something goes really wrong and it's not possible to mount
> it.

Could we at the very least see a copy of your /etc/exports
and /etc/fstab please?

Cheers,
  Trond

