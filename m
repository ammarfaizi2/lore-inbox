Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277437AbRJOL5t>; Mon, 15 Oct 2001 07:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277434AbRJOL5g>; Mon, 15 Oct 2001 07:57:36 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:12219 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S277437AbRJOL5Q>;
	Mon, 15 Oct 2001 07:57:16 -0400
Date: Mon, 15 Oct 2001 07:57:47 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] "Text file busy" when overwriting libraries
In-Reply-To: <E15t6K3-0001tK-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0110150751540.8707-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Oct 2001, Alan Cox wrote:

> Which is mostly useless anyway since anyone can write an ld-linux that
> doesn't check providing the binary is readable. noexec is basically a weird
> ancient unixism that is usless.

Anyone can write it, but what the hell will he do without write access to
any place that wouldn't be mounted noexec?  Environment can be restricted
even if you give them shell...

