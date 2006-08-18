Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWHRSsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWHRSsy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 14:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWHRSsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 14:48:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47771 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750717AbWHRSsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 14:48:53 -0400
Date: Fri, 18 Aug 2006 11:48:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thierry Vignaud <tvignaud@mandriva.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: +
 support-piping-into-commands-in-proc-sys-kernel-core_pattern.patch added to
 -mm tree
Message-Id: <20060818114835.bcdac825.akpm@osdl.org>
In-Reply-To: <m2fyftevt0.fsf@vador.mandriva.com>
References: <200608161809.k7GI9ODk007199@shell0.pdx.osdl.net>
	<m2fyftevt0.fsf@vador.mandriva.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2006 20:35:39 +0200
Thierry Vignaud <tvignaud@mandriva.com> wrote:

> akpm@osdl.org writes:
> 
> > Subject: Support piping into commands in /proc/sys/kernel/core_pattern
> > From: Andi Kleen <ak@suse.de>
> > 
> > Using the infrastructure created in previous patches implement support to
> > pipe core dumps into programs.
> > 
> > This is done by overloading the existing core_pattern sysctl
> > with a new syntax:
> > 
> > |program
> 
> nice but what if the core analyzer segfaults too? looping? DOS
> coredumping :-) ?

rofl.  Good question ;)
