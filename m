Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265259AbSIQXWF>; Tue, 17 Sep 2002 19:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265262AbSIQXWF>; Tue, 17 Sep 2002 19:22:05 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:56510 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265259AbSIQXWE>;
	Tue, 17 Sep 2002 19:22:04 -0400
Date: Tue, 17 Sep 2002 19:26:45 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "David J. M. Karlsen" <david@davidkarlsen.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: sanatize kdev_t?
In-Reply-To: <3D87B7C2.40401@davidkarlsen.com>
Message-ID: <Pine.GSO.4.21.0209171923180.3663-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Sep 2002, David J. M. Karlsen wrote:

> lvm.c:1: #error Broken until maintainers will sanitize kdev_t handling
 
> so - is sanatizing far away? whats changed - and why. I'd love to 
> experiment a little with 2.5.x - but I really need the md and lvm stuff.

LVM1 is dead.  LVM maintainers had explicitly stated on l-k and elsewhere
that it will be kept (in mainenance-only mode) only in 2.4; they are going
to merge LVM2 in 2.5 at some point and that's it.

