Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265804AbUBBT3V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 14:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265795AbUBBT3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 14:29:21 -0500
Received: from waste.org ([209.173.204.2]:33230 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S265804AbUBBT3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 14:29:20 -0500
Date: Mon, 2 Feb 2004 13:29:05 -0600
From: Matt Mackall <mpm@selenic.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.2-rc3-tiny1 for small systems
Message-ID: <20040202192905.GA21888@waste.org>
References: <20040201052348.GW21888@waste.org> <20040202183944.GB3177@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202183944.GB3177@fs.tum.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 02, 2004 at 07:39:44PM +0100, Adrian Bunk wrote:
> On Sat, Jan 31, 2004 at 11:23:48PM -0600, Matt Mackall wrote:
> >...
> 
> The patch contains 3 .orig files that could be removed:
> linux-2.6.2-rc3/arch/i386/boot/compressed/misc.c.orig
> linux-2.6.2-rc3/arch/i386/mm/init.c.orig
> linux-2.6.2-rc3/fs/proc/proc_misc.c.orig
> 
> > Latest release includes:
> >...
> >  - enhanced CPU feature selection (Adrian Bunk)
> >...
> 
> You could kill all the CPU_SUP_* options with my CPU selection scheme.

I looked at that but ended up deciding I still didn't have the desired
granularity. So I'm currently thinkg of your stuff as "select family"
and my stuff as "select vendor support".

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
