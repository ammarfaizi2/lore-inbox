Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132606AbRDOIsA>; Sun, 15 Apr 2001 04:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132607AbRDOIru>; Sun, 15 Apr 2001 04:47:50 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:46732 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132606AbRDOIrl>;
	Sun, 15 Apr 2001 04:47:41 -0400
Date: Sun, 15 Apr 2001 04:47:39 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Swivel <swivel@null.pharm.uic.edu>, linux-kernel@vger.kernel.org
Subject: Re: small bug/oversight found in 2.4.3
In-Reply-To: <3AD95C7F.51E07B36@mandrakesoft.com>
Message-ID: <Pine.GSO.4.21.0104150446310.889-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 15 Apr 2001, Jeff Garzik wrote:

> Swivel wrote:
> > 
> > drivers/char/char.c, line 247
> > create_proc_read_entry() is called regardless of the definition of
> > CONFIG_PROC_FS, simply wrap call with #ifdef CONFIG_PROC_FS and #endif.
> 
> create_proc_read_entry exists, as a static inline no-op, without
> CONFIG_PROC_FS.

... while drivers/char/char.c doesn't exist at all.

