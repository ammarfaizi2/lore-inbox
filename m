Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262576AbRENXYH>; Mon, 14 May 2001 19:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262575AbRENXX5>; Mon, 14 May 2001 19:23:57 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:8646 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262573AbRENXXk>;
	Mon, 14 May 2001 19:23:40 -0400
Date: Mon, 14 May 2001 19:23:38 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <E14zRFZ-0001dI-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0105141900420.19333-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 May 2001, Alan Cox wrote:

> grep MAJOR lilo-21.4.4/*|wc -l
>     323

/me looks and barfs.

Alan, had you actually looked at it? It will require massive changes
whenever you introduce new major. And most of such areas are stuff
that doesn't matter for new devices anyway - geometry, example.

