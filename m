Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbTJUEXM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 00:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbTJUEXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 00:23:12 -0400
Received: from pizda.ninka.net ([216.101.162.242]:3228 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262907AbTJUEWV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 00:22:21 -0400
Date: Mon, 20 Oct 2003 21:17:06 -0700
From: "David S. Miller" <davem@redhat.com>
To: Martin Diehl <lists@mdiehl.de>
Cc: noah@caltech.edu, irda-users@lists.sourceforge.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [irda-users] [PATCH] Make VLSI FIR depend on X86
Message-Id: <20031020211706.5be33474.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0310201138020.4246-100000@notebook.home.mdiehl.de>
References: <Pine.GSO.4.58.0310171456080.13905@blinky>
	<Pine.LNX.4.44.0310201138020.4246-100000@notebook.home.mdiehl.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Oct 2003 19:30:33 +0200 (CEST)
Martin Diehl <lists@mdiehl.de> wrote:

> Well, it would work with any arch, _if_ there was a way to sync the 
> streaming pci dma buffers before giving them back to hardware.

If pci_dma_sync() doesn't perform the operation you want, please
describe what that operation is.
