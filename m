Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130532AbRDWE7h>; Mon, 23 Apr 2001 00:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130768AbRDWE70>; Mon, 23 Apr 2001 00:59:26 -0400
Received: from snowbird.megapath.net ([216.200.176.7]:3850 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S130532AbRDWE7M>;
	Mon, 23 Apr 2001 00:59:12 -0400
Date: Sun, 22 Apr 2001 21:54:55 -0700 (PDT)
From: Miles Lane <miles@megapathdsl.net>
To: "David S. Miller" <davem@redhat.com>
cc: Russell King <rmk@arm.linux.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: All architecture maintainers: pgd_alloc()
In-Reply-To: <15075.45847.624767.960502@pizda.ninka.net>
Message-ID: <Pine.LNX.4.30.0104222144290.6639-100000@aerie.megapathdsl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Apr 2001, David S. Miller wrote:

>
> Russell King writes:
>  > There are various options here:
>  >
>  > 1. Either I can fix up all architectures, and send a patch to this list, or
>
> Fixup all the architectures and send this and the ARM bits to Linus.
>
> I really would wish folks would not choose Alan as the first place
> to send the patch.  I'm not directly accusing anyone of it, but it
> does appear that often AC is used as a "back door" to get a change
> in.  While this scheme most of the time, often it unnecessarily
> overworks Alan which I think is unfair.

Hi David,

While I agree that this state of affairs must be taxing Alan,
it was my understanding that this situation was _intended_.
It's been explicitly stated, IIRC, that only really important
bug fixes for very well-defined problems should be going
to Linus.  This was announced around the time of the 2.4 launch.
The reasoning being that Linus wanted to be assured that we
would not have a backslide in kernel stability after the 2.4
launch, like happened after the 2.2 launch.  My understanding
is that Alan is acting as gatekeeper for the experimental
and lower priority patches until after the 2.5 kernel opens
up.  Of course, then the 2.4 maintainer (who will likely
be Alan?) will be receiving 2.4 patches, while Linus begins
receiving all things 2.5 (experimental or not).  My guess
(perhaps grossly incorrect) is that the flow rate of patches
after the 2.5 tree opens will be pretty evenly split between
2.5 and 2.4.

Again, IIRC, Linus wanted to stay really focused on the 2.4
kernel stability.  Having Alan shielding him from the huge
quantity of patches has probably helped him be effective in
making sure patches in the 2.4.x-pre series are good stuff.

Have I got this right?

Cheers,
	Miles

