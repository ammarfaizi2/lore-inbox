Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWAFDRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWAFDRl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 22:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932626AbWAFDRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 22:17:41 -0500
Received: from xenotime.net ([66.160.160.81]:2489 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932167AbWAFDRk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 22:17:40 -0500
Date: Thu, 5 Jan 2006 19:17:36 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Komuro <komurojun-mbn@nifty.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [KERNEL 2.6.15]  All files have -rw-rw-rw- permission.
Message-Id: <20060105191736.1ac95e4b.rdunlap@xenotime.net>
In-Reply-To: <1986219.1136463311449.komurojun-mbn@nifty.com>
References: <1986219.1136463311449.komurojun-mbn@nifty.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2006 21:15:11 +0900 (JST) Komuro wrote:

> Hello,
> 
> All files have -rw-rw-rw- permission.(kernel 2.6.15, 2.6.14)
> 
> for example,
> -rw-rw-rw-  1 root root 65359 Jan  3 12:21 MAINTAINERS
> 
> Is this correct?

Hi,
We (lkml) have been thru this before.
Don't untar the tarball as root and this won't happen.

---
~Randy
