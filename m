Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130255AbRBNRwp>; Wed, 14 Feb 2001 12:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130235AbRBNRwZ>; Wed, 14 Feb 2001 12:52:25 -0500
Received: from jdewell.coloc.xmission.com ([204.228.135.205]:37249 "HELO
	a.smtp.woods.net") by vger.kernel.org with SMTP id <S129075AbRBNRwO>;
	Wed, 14 Feb 2001 12:52:14 -0500
Date: Wed, 14 Feb 2001 10:54:18 -0700 (MST)
From: Aaron Dewell <acd@woods.net>
To: Anton Blanchard <anton@linuxcare.com.au>
Cc: "ASN Stevens, Computing Service" <Alastair.Stevens@bristol.ac.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.1-ac12 compile failure on sparc64
In-Reply-To: <20010214224148.C2132@linuxcare.com>
Message-ID: <Pine.GSO.4.10.10102141051540.4058-100000@spruce.woods.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It's a quick change at arch/sparc64/kernel/sys_sparc32.c:907 from:

        struct dqblk d;

to:
        struct disk_dqblk d;

Compiles and works great on my ultra.

On Wed, 14 Feb 2001, Anton Blanchard wrote:
> > Hi - I am having compilation troubles on my sparc64 workstation (standard 
> > Ultra 5 machine), which is currently running stock 2.4.1 on Red Hat 6.2 quite 
> > happily.
> 
> We arent tracking the -ac patches at the moment and alan can't be expected
> to ensure it compiles on all architectures. Best bet is to stick with
> Linus releases.
> 
> Anton

