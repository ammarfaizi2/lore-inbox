Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269188AbUJKTI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269188AbUJKTI6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 15:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269193AbUJKTI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 15:08:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:8929 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269188AbUJKTIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 15:08:50 -0400
Date: Mon, 11 Oct 2004 12:12:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: davej@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: __init dependencies (was: Re: [PATCH] find_isa_irq_pin can't be
 )__init
Message-Id: <20041011121225.2f829507.akpm@osdl.org>
In-Reply-To: <Pine.GSO.4.61.0410111333260.19312@waterleaf.sonytel.be>
References: <20041010225717.GA27705@redhat.com>
	<Pine.GSO.4.61.0410111333260.19312@waterleaf.sonytel.be>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> I guess it's about time for a tool to autodetect __init dependencies?

`make buildcheck' does this.  Looks like nobody is using it.
