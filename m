Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262525AbRENWFm>; Mon, 14 May 2001 18:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262526AbRENWFc>; Mon, 14 May 2001 18:05:32 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:14560 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262525AbRENWFV>;
	Mon, 14 May 2001 18:05:21 -0400
Date: Mon, 14 May 2001 18:05:15 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <E14zPhr-0001RP-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0105141748180.19333-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 May 2001, Alan Cox wrote:

> Abstract device file systems are beautiful concepts but they don't solve
> the device name space problem and they introduce hideous incompatibilities
> with existing software. 

let me get it straight. You are talking about software that would be
	a) device-specific,
	b) Linux-only,
	c) working with devices that do not exist in 2.4.

Would you mind demonstrating such wonder? Old devices are still there,
AFAICS. Ext2 (reiserfs, devfs, abortion-of-your-choice-fs) still has
the ability to create device nodes for them.

