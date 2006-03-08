Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751675AbWCHAeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbWCHAeF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 19:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbWCHAeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 19:34:05 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:5349 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751675AbWCHAeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 19:34:03 -0500
Subject: Re: [PATCH] Document Linux's memory barriers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: "Bryan O'Sullivan" <bos@serpentine.com>,
       David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200603072224.09976.ak@suse.de>
References: <200603071134.52962.ak@suse.de> <200603071257.24234.ak@suse.de>
	 <1141766085.5255.12.camel@serpentine.pathscale.com>
	 <200603072224.09976.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Mar 2006 00:36:58 +0000
Message-Id: <1141778218.2455.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-03-07 at 22:24 +0100, Andi Kleen wrote:
> > But on most arches those accesses do indeed seem to happen in-order.  On
> > i386 and x86_64, it's a natural consequence of program store ordering.
> 
> Not true for reads on x86.

You must have a strange kernel Andi. Mine marks them as volatile
unsigned char * references.

Alan

