Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136022AbRD0NZq>; Fri, 27 Apr 2001 09:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136031AbRD0NZg>; Fri, 27 Apr 2001 09:25:36 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:15092 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S136022AbRD0NZX>;
	Fri, 27 Apr 2001 09:25:23 -0400
Date: Fri, 27 Apr 2001 09:23:57 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Linus Torvalds <torvalds@transmeta.com>, Andrea Arcangeli <andrea@suse.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <20010427095840.A701@suse.cz>
Message-ID: <Pine.GSO.4.21.0104270922360.18661-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Apr 2001, Vojtech Pavlik wrote:

> Actually this is done quite often, even on mounted fs's:
> 
> hdparm -t /dev/hda

You would need either hdparm -t /dev/hda<something> or mounting the
whole /dev/hda.

Buffer cache for the disk is unrelated to buffer cache for parititions.

