Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271713AbRHUOyS>; Tue, 21 Aug 2001 10:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271714AbRHUOyH>; Tue, 21 Aug 2001 10:54:07 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:58324 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S271713AbRHUOxz>;
	Tue, 21 Aug 2001 10:53:55 -0400
Date: Tue, 21 Aug 2001 10:54:07 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "David S. Miller" <davem@redhat.com>, jes@sunsite.dk,
        linux-kernel@vger.kernel.org
Subject: Re: Qlogic/FC firmware
In-Reply-To: <E15ZCS1-0007xV-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0108211049250.6448-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Aug 2001, Alan Cox wrote:

> Why. What exactly is your argument ? Lets waste 128K of kernel space to keep
> Dave happy. If the lack of proper boot time init on the sparc64 platform is
> causing more problems then copy the firmware image out of the BIOS into the
> card if sparc64 is defined.
> 
> And an initrd is the right answer. You free up the 128K of wasted space
> using it.

initrd is the right answer to question "where can I find shitty code?"

Now, having firmware loaded from userland _is_ nice and sane, but we
need something better than initrd for that.

