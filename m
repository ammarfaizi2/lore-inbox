Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277143AbRKVLGb>; Thu, 22 Nov 2001 06:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277228AbRKVLGL>; Thu, 22 Nov 2001 06:06:11 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:34256 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S277143AbRKVLGI>; Thu, 22 Nov 2001 06:06:08 -0500
Date: Thu, 22 Nov 2001 12:02:47 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Pavel Machek <pavel@suse.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Disabling FPU, MMX, SSE units?
In-Reply-To: <20011121220544.A7357@elf.ucw.cz>
Message-ID: <Pine.GSO.3.96.1011122120030.29116A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2001, Pavel Machek wrote:

> Is there way not to let linux use FPU, MMX, SSE and similar fancy
> units? I have athlon processor, but would like to turn FPU (and
> similar fancy stuff) off...

 You may use "no387" to disable FPU and MMX (they are controlled by a
single bit in cr0).  No idea about SSE.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

