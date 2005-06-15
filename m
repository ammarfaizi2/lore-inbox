Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVFOPbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVFOPbL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 11:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVFOPbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 11:31:11 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:20239 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261170AbVFOPbK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 11:31:10 -0400
Date: Wed, 15 Jun 2005 16:30:37 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: 7eggert@gmx.de
Cc: Gene Heskett <gene.heskett@verizon.net>, cutaway@bellsouth.net,
       linux-kernel@vger.kernel.org
Subject: Re: .../asm-i386/bitops.h  performance improvements
In-Reply-To: <E1DiZKe-0000em-58@be1.7eggert.dyndns.org>
Message-ID: <Pine.LNX.4.61L.0506151629270.13835@blysk.ds.pg.gda.pl>
References: <4fB8l-73q-9@gated-at.bofh.it> <4fF2j-1Lo-19@gated-at.bofh.it>
 <E1DiZKe-0000em-58@be1.7eggert.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2005, Bodo Eggert wrote:

> lea is an 8086 instruction. All clones have it in it's basic form. However,
> the multiplicator is not documented for i486, therefore it will be a i586
> extension.

 Huh?  The SIB byte has been added in the original i386 with 32-bit 
addressing.

  Maciej
