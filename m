Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317023AbSFZWQa>; Wed, 26 Jun 2002 18:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317030AbSFZWQ3>; Wed, 26 Jun 2002 18:16:29 -0400
Received: from web30.achilles.net ([209.151.1.2]:57236 "EHLO
	web30.achilles.net") by vger.kernel.org with ESMTP
	id <S317023AbSFZWQ2>; Wed, 26 Jun 2002 18:16:28 -0400
Subject: Re: x86 Page Sizes
From: Robert Love <rml@tech9.net>
To: Dan Sturtevant <dsturtev@plogic.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0206261759230.11230-100000@milhouse.plogic.internal>
References: <Pine.LNX.4.44.0206261759230.11230-100000@milhouse.plogic.internal>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 26 Jun 2002 18:11:08 -0400
Message-Id: <1025129491.1144.7.camel@icbm>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-06-26 at 18:02, Dan Sturtevant wrote:
> 
> I know the x86 linux kernel has 4K pages in userspace and 4M pages in 
> kernel space.  These two sizes seem to be limitations of the intel 
> architecture (I think).
> 
> Does anyone know a way to increase the userspace page size above 4K?
> Are there any patches for a 4M userspace pagesize?

Kernel has 4K pages in user and kernel space.  It is the same address
space and segment, just uses MMU protection.

x86 does 4K pages.

	Robert Love

