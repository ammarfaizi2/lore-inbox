Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268061AbUBRUeP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 15:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268064AbUBRUeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 15:34:15 -0500
Received: from ns.suse.de ([195.135.220.2]:52393 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268061AbUBRUeK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 15:34:10 -0500
Date: Thu, 19 Feb 2004 02:11:49 +0100
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Enable Intel AGP on x86-64
Message-Id: <20040219021149.519d0754.ak@suse.de>
In-Reply-To: <20040218202325.GZ6242@redhat.com>
References: <200402182006.i1IK6bL7022634@hera.kernel.org>
	<20040218202325.GZ6242@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Feb 2004 20:23:25 +0000
Dave Jones <davej@redhat.com> wrote:

> On Wed, Feb 18, 2004 at 07:44:38PM +0000, Linux Kernel wrote:
>  > ChangeSet 1.1564, 2004/02/18 11:44:38-08:00, ak@suse.de
>  > 
>  > 	[PATCH] Enable Intel AGP on x86-64
>  > 	
>  > 	Enable the Intel AGP driver for x86-64 too.
> 
> Please don't do this. At least copy intel-agp.c to
> something new and throw out all the dozens of chipsets
> that will never appear on ia32e.
> 
> Splitting agpgart up to seperate drivers allowed us
> to stop adding cruft upon cruft with each generation
> of chipsets.  I don't want to have to spend half of
> 2.7 decrufting agpgart again.

Huh? Did you actually read the patch? It doesn't change the AGP
driver at all, just enables it in Kconfig because Intel chipsets
can be now used on the x86-64 kernel too.

-Andi
