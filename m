Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282082AbRLQSpt>; Mon, 17 Dec 2001 13:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282092AbRLQSpA>; Mon, 17 Dec 2001 13:45:00 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:14041 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S282133AbRLQSol>;
	Mon, 17 Dec 2001 13:44:41 -0500
Date: Mon, 17 Dec 2001 13:44:37 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Torrey Hoffman <torrey.hoffman@myrio.com>
cc: "'Mike Galbraith'" <mikeg@wen-online.de>,
        vda <vda@port.imtp.ilyichevsk.odessa.ua>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: pivot_root and initrd kernel panic woes
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CB07@mail0.myrio.com>
Message-ID: <Pine.GSO.4.21.0112171343420.3992-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Dec 2001, Torrey Hoffman wrote:

> Some of them boot and some of them don't.  I can take a non-working
> image, gunzip it, dd it back to the ramdisk, mount it, and 
> recursively diff it against the original rootfs and find nothing
> wrong. 

Check permissions/ownership.  That doesn't show up in diff...

