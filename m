Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbVGJBGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbVGJBGV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 21:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVGJBGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 21:06:21 -0400
Received: from graphe.net ([209.204.138.32]:30670 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261808AbVGJBGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 21:06:20 -0400
Date: Sat, 9 Jul 2005 18:06:11 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andi Kleen <ak@suse.de>
cc: Bob Picco <bob.picco@hp.com>, linux-mm@kvack.org, manfred@colorfullife.com,
       alex.williamson@hp.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Early kmalloc/kfree
In-Reply-To: <p73zmsxncym.fsf@verdi.suse.de>
Message-ID: <Pine.LNX.4.62.0507091801170.22975@graphe.net>
References: <20050708203807.GG27544@localhost.localdomain.suse.lists.linux.kernel>
 <p73zmsxncym.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jul 2005, Andi Kleen wrote:

> I think that is a really really bad idea.   slab is already complex enough
> and adding scary hacks like this will probably make it collapse
> under its own weight at some point.

Seconded.

Maybe we can solve this by bringing the system up in a limited 
configuration and then discover additional capabilities during ACPI 
discovery and reconfigure.
