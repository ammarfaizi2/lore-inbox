Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268288AbUIGSNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268288AbUIGSNK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 14:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268289AbUIGSK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 14:10:29 -0400
Received: from the-village.bc.nu ([81.2.110.252]:30117 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268288AbUIGSKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 14:10:04 -0400
Subject: Re: [PATCH] unexport get_wchan
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040907144539.GA8808@lst.de>
References: <20040907144539.GA8808@lst.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094576868.9607.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 07 Sep 2004 18:07:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-07 at 15:45, Christoph Hellwig wrote:
> only usedby procfs which certainly can't be modular

And multiple out of tree debuggers. Christoph - do some basic homework.
Also save the "so merge it" crap for someone else before you come up
with that comment. Given the choice between a few exports of relevant
functionality and merging some of the open source stuff that uses it we
are far far better off with the export.

Plus Linus has a random personal and unreasonable hatred of debugging
tools so they'll never get merged anyway without forking the kernel.

Alan

