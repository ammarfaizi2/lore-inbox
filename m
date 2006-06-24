Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932934AbWFXHCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932934AbWFXHCz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 03:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932935AbWFXHCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 03:02:55 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:31715 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S932934AbWFXHCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 03:02:54 -0400
Date: Sat, 24 Jun 2006 16:02:51 +0900 (JST)
Message-Id: <20060624.160251.1849029656529675150.masano@tnes.nec.co.jp>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] add lookup hint for network file systems
From: ASANO Masahiro <masano@tnes.nec.co.jp>
In-Reply-To: <20060623230503.003c51af.akpm@osdl.org>
References: <20060623.210430.2110776701550307243.masano@tnes.nec.co.jp>
	<20060623230503.003c51af.akpm@osdl.org>
X-Mailer: Mew version 4.2 on XEmacs 21.5-b21 (corn)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew.

On Fri, 23 Jun 2006 23:05:03 -0700,
Andrew Morton <akpm@osdl.org> wrote:
> > Here is a sample patch which uses LOOKUP_CREATE and O_EXCL on mkdir,
> > symlink and mknod.  This uses the gadget for creat(2).

> whoa.  Big patch ;)

Thank you for your comment.
We briefly discussed this idea last week at Tokyo.
