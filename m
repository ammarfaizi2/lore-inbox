Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbVGaQpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVGaQpM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 12:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVGaQpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 12:45:12 -0400
Received: from xenotime.net ([66.160.160.81]:30672 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S261826AbVGaQpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 12:45:05 -0400
Date: Sun, 31 Jul 2005 09:44:58 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc4-mm1
Message-Id: <20050731094458.72dddfde.rdunlap@xenotime.net>
In-Reply-To: <20050731020552.72623ad4.akpm@osdl.org>
References: <20050731020552.72623ad4.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Jul 2005 02:05:52 -0700 Andrew Morton wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc4/2.6.13-rc4-mm1/
> 

> - Dropped the connector patches: turns out that we no longer have a netlink
>   slot available for them anyway.

I don't feel strongly pro or con about the connector patches, but
DaveM suggested using a netlink multiplexer for iscsi (which also
needs a netlink slot), so presumably that could work for the
connector patches also...?

---
~Randy
