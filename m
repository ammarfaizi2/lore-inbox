Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317309AbSGDBpp>; Wed, 3 Jul 2002 21:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317312AbSGDBpo>; Wed, 3 Jul 2002 21:45:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3344 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317309AbSGDBpn>;
	Wed, 3 Jul 2002 21:45:43 -0400
Message-ID: <3D23AAB3.1AF2F897@zip.com.au>
Date: Wed, 03 Jul 2002 18:53:55 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: simple handling of module removals Re: [OKS] Module removal
References: Your message of "Wed, 03 Jul 2002 05:48:09 +0200."
	             <20020703034809.GI474@elf.ucw.cz> <10962.1025745528@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> ...
> Rusty and I agree that if (and it's a big if) we want to support module
> unloading safely then this is the only sane way to do it.

Dumb question: what's wrong with the current code as-is?  I don't think
I've ever seen a module removal bug report which wasn't attributable to
some straightforward driver-failed-to-clean-something-up bug.

What problem are you trying to solve here?

-
