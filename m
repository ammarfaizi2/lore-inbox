Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbVI1W4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbVI1W4O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 18:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbVI1W4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 18:56:14 -0400
Received: from [81.2.110.250] ([81.2.110.250]:11196 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751149AbVI1W4N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 18:56:13 -0400
Subject: Re: Strange disk corruption with Linux >= 2.6.13
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: vherva@vianova.fi
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050928084330.GC24760@viasys.com>
References: <20050927111038.GA22172@ime.usp.br>
	 <20050928084330.GC24760@viasys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 29 Sep 2005 00:23:28 +0100
Message-Id: <1127949809.26686.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-09-28 at 11:43 +0300, Ville Herva wrote:
> I NEVER got the board stable, and ended up ditching it.
> 
> It seemed to be a KT133 Northbridge DMA issue. My impression is that KT133
> is utter crap period.

It was a FIFO bug, but the kernel knows about it and it should handle
this correctly. Is the hard disk running UDMA133 ?


