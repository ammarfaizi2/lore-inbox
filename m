Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbULZXNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbULZXNQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 18:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbULZXNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 18:13:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:58581 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261180AbULZXNN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 18:13:13 -0500
Date: Sun, 26 Dec 2004 15:12:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Florian Weimer <fw@deneb.enyo.de>
cc: 7eggert@gmx.de, Christoph Lameter <clameter@sgi.com>, akpm@osdl.org,
       linux-ia64@vger.kernel.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: Prezeroing V2 [3/4]: Add support for ZEROED and NOT_ZEROED free
 maps
In-Reply-To: <87wtv464ty.fsf@deneb.enyo.de>
Message-ID: <Pine.LNX.4.58.0412261511030.2353@ppc970.osdl.org>
References: <fa.n0l29ap.1nqg39@ifi.uio.no> <fa.n04s9ar.17sg3f@ifi.uio.no>
 <E1ChwhG-00011c-00@be1.7eggert.dyndns.org> <87wtv464ty.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 27 Dec 2004, Florian Weimer wrote:
> 
> But overwritting with zeros is commonly called "scrubbing", as in
> "password scrubbing".

On the other hand, "memory scrubbing" in an OS sense is most often used
for reading and re-writing the same thing to fix correctable ECC failures.

Anyway, at this point I think the most interesting question is whether it 
actually improves any macro-benchmark behaviour, rather than just a page 
fault latency tester microbenchmark..

		Linus
