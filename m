Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965780AbWKEBys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965780AbWKEBys (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 20:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965781AbWKEBys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 20:54:48 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58577 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965780AbWKEByr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 20:54:47 -0500
Subject: Re: New filesystem for Linux
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0611041938490.24713@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
	 <454A76CC.6030003@cosmosbay.com>
	 <Pine.LNX.4.64.0611041938490.24713@artax.karlin.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 05 Nov 2006 01:58:56 +0000
Message-Id: <1162691936.21654.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-11-04 am 19:40 +0100, ysgrifennodd Mikulas Patocka:
> > The problem with a per_cpu biglock is that you may consume a lot of RAM for 
> > big NR_CPUS. Count 32 KB per 'biglock' if NR_CPUS=1024
> 
> Does one Linux kernel run on system with 1024 cpus? I guess it must fry 
> spinlocks... (or even lockup due to spinlock livelocks)

Altix goes that big and bigger. 

Alan
