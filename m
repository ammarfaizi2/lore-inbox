Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284704AbRLRSzn>; Tue, 18 Dec 2001 13:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284761AbRLRSyS>; Tue, 18 Dec 2001 13:54:18 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:2982 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S284711AbRLRSxX>;
	Tue, 18 Dec 2001 13:53:23 -0500
Date: Tue, 18 Dec 2001 13:53:21 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: "'James A Sutherland'" <james@sutherland.net>,
        "'otto.wyss@bluewin.ch'" <otto.wyss@bluewin.ch>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Booting a modular kernel through a multiple streams file
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D803@orsmsx111.jf.intel.com>
Message-ID: <Pine.GSO.4.21.0112181346250.7996-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Dec 2001, Grover, Andrew wrote:

> 1) GRUB can already do this
> 2) Each bootloader doesn't need to link, the kernel includes the linker.
> (which after it does its job can be discarded and insmod used later on)
> 3) Seeing how ugly everyone seems to think initrd is, this seems like a
> worthwhile option to consider.

Sigh...  You end up adding more code to kernel _and_ keeping initrd
code in there.  And that's supposed to be an improvement?

