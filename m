Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264019AbUEHSCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264019AbUEHSCj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 14:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264026AbUEHSCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 14:02:39 -0400
Received: from smtprelay02.ispgateway.de ([62.67.200.157]:34471 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S264019AbUEHSCe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 14:02:34 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] [PATCH] Node Hotplug Support
Date: Sat, 8 May 2004 20:00:17 +0200
User-Agent: KMail/1.6.2
Cc: Andi Kleen <ak@muc.de>,
       Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
References: <1TfLX-4M4-9@gated-at.bofh.it> <m34qqshx31.fsf@averell.firstfloor.org>
In-Reply-To: <m34qqshx31.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200405082000.23118.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 07 May 2004 21:10, Andi Kleen wrote:
> Admittedly there would still need to be some coordination in case you
> would want to remove a whole building block of your machine like 
> you said. An nice way to do this would be to add an atomic "to be removed"
> state to the individual unregister mechanisms that prevents the 
> device from being reregistered until removed.
 
This is also needed for "to be replaced" state.
Imagine a node with b0rken CPU, where you still like to use its memory.

Both states can be the same actually ;-)


Regards

Ingo Oeser

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAnSA1U56oYWuOrkARAnjYAJ9CfcVGC9GnqlmvSpwRzI10jj7WGwCguKYq
qtawhKJiy/j8r0d3qfqBrSw=
=Z+oX
-----END PGP SIGNATURE-----

