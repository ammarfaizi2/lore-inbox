Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263654AbTJORRG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 13:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263698AbTJORRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 13:17:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:18101 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263654AbTJORRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 13:17:03 -0400
Date: Wed, 15 Oct 2003 10:20:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: pavel@ucw.cz, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: mem=16MB laptop testing
Message-Id: <20031015102029.58971c62.akpm@osdl.org>
In-Reply-To: <20031015153212.GA5197@redhat.com>
References: <20031014105514.GH765@holomorphy.com>
	<20031014045614.22ea9c4b.akpm@osdl.org>
	<20031015121208.GA692@elf.ucw.cz>
	<20031015125109.GQ16158@holomorphy.com>
	<20031015132054.GA840@elf.ucw.cz>
	<20031015153212.GA5197@redhat.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> [PATCH] memsetup fixes (again)
> 
>  The mem= fixes from Red Hat's tree had a small bug:
>  if mem= was not actually used with the additional features, but
>  int plain old way, is used the value as the size of memory it
>  wants, not the upper limit.  The problem with this is that there
>  is a small difference due to memory holes.
>  				    
>  I had one report of a person using mem= to reduce memory size for
>  a broken i386 chipset thaty only supports 64MB cached and the rest
>  as mtd/slram device for swap.  I got broken as the boundaries changed.
> 
> 
>  Assuming this patch is correct, it needs forward porting to 2.6

I'll queue up a patch to do that.


