Return-Path: <linux-kernel-owner+w=401wt.eu-S932268AbXARVxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbXARVxj (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 16:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbXARVxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 16:53:39 -0500
Received: from smtp.osdl.org ([65.172.181.24]:47343 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932268AbXARVxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 16:53:38 -0500
Date: Thu, 18 Jan 2007 13:53:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: anemo@mba.ocn.ne.jp, linux-kernel@vger.kernel.org,
       linux-mips@linux-mips.org
Subject: Re: [PATCH] Make CARDBUS_MEM_SIZE and CARDBUS_IO_SIZE customizable
Message-Id: <20070118135326.c0238873.akpm@osdl.org>
In-Reply-To: <20070118160338.GA6343@linux-mips.org>
References: <20070119.002346.74752797.anemo@mba.ocn.ne.jp>
	<20070118160338.GA6343@linux-mips.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 18 Jan 2007 16:03:38 +0000 Ralf Baechle <ralf@linux-mips.org> wrote:
> On Fri, Jan 19, 2007 at 12:23:46AM +0900, Atsushi Nemoto wrote:
> 
> > CARDBUS_MEM_SIZE was increased to 64MB on 2.6.20-rc2, but larger size
> > might result in allocation failure for the reserving itself on some
> > platforms (for example typical 32bit MIPS).  Make it (and
> > CARDBUS_IO_SIZE too) customizable for such platforms.
> 
> Patch looks technically ok to me, so feel free to add my Acked-by: line.
> 
> The grief I have with this sort of patch is that this kind of detailed
> technical knowledge should not be required by a mortal configuring the
> Linux kernel.
> 

Yes, it does rater suck.  A boot option/module parameter would be better.
