Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268073AbUIGSEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268073AbUIGSEo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 14:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268234AbUIGSEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 14:04:44 -0400
Received: from the-village.bc.nu ([81.2.110.252]:27557 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268073AbUIGSEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 14:04:43 -0400
Subject: Re: [PATCH] unexport do_execve/do_select
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040907150028.GA9235@lst.de>
References: <20040907150028.GA9235@lst.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094576549.9599.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 07 Sep 2004 18:02:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-07 at 16:00, Christoph Hellwig wrote:
> These are basically shared code for native/32bit compat code, but as
> CONFIG_COMPAT is a bool there's no need to export them.

do_select at least used to be used by the xABI compatibility modules, is
that no longer the case ?

