Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbTJUISg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 04:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbTJUISg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 04:18:36 -0400
Received: from pizda.ninka.net ([216.101.162.242]:5789 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262882AbTJUISf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 04:18:35 -0400
Date: Tue, 21 Oct 2003 01:13:20 -0700
From: "David S. Miller" <davem@redhat.com>
To: Martin Diehl <lists@mdiehl.de>
Cc: lists@mdiehl.de, noah@caltech.edu, irda-users@lists.sourceforge.net,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [irda-users] [PATCH] Make VLSI FIR depend on X86
Message-Id: <20031021011320.3fa6888f.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0310210929350.4246-100000@notebook.home.mdiehl.de>
References: <20031021001241.390a16df.davem@redhat.com>
	<Pine.LNX.4.44.0310210929350.4246-100000@notebook.home.mdiehl.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Oct 2003 09:33:24 +0200 (CEST)
Martin Diehl <lists@mdiehl.de> wrote:

> One more question: Shouldn't the i386 implementation instead of being NOP 
> just call flush_write_buffers() - at least this is what the vlsi-private 
> implementation is doing at the moment?

That seems right, yes.
