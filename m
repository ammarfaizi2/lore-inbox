Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273588AbRIUPwt>; Fri, 21 Sep 2001 11:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273584AbRIUPwj>; Fri, 21 Sep 2001 11:52:39 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:26009 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S273588AbRIUPwZ>;
	Fri, 21 Sep 2001 11:52:25 -0400
Date: Fri, 21 Sep 2001 11:52:49 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Steinmetz <ast@domdv.de>
cc: Nick Ivanter <nick@emcraft.ru>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-pre13: Panic mounting initrd
In-Reply-To: <XFMail.20010921173903.ast@domdv.de>
Message-ID: <Pine.GSO.4.21.0109211147380.8014-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 21 Sep 2001, Andreas Steinmetz wrote:

> This clearly shows that there's definitely something going _very_ wrong.
> Best bet is loading/decompression of initrd. As far as I'm following the list
> there were initrd modifications discussed/done by Alexander Viro/Andrea
> Arcangeli.

Not between -pre12 and -pre13, actually.  OTOH, new rd.c code _is_ new
and VM modifications between -pre12 and -pre13 might affect it.

rd.c _is_ screwed up right now, so I'd recommend to be careful with
vanilla -pre12 or -pre13.  I'm merging Andrea's stuff for normal
ramdisks with, erm, getting initrd into sane state, so as soon as
it gets local testing I'll post the patch.

