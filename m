Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271882AbRHUWpv>; Tue, 21 Aug 2001 18:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271883AbRHUWpm>; Tue, 21 Aug 2001 18:45:42 -0400
Received: from sweetums.bluetronic.net ([24.162.254.3]:47540 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S271882AbRHUWp2>; Tue, 21 Aug 2001 18:45:28 -0400
Date: Tue, 21 Aug 2001 18:45:02 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetopia.net>
X-X-Sender: <jfbeam@sweetums.bluetronic.net>
To: Rik van Riel <riel@conectiva.com.br>
cc: "David S. Miller" <davem@redhat.com>, <alan@lxorguk.ukuu.org.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Qlogic/FC firmware
In-Reply-To: <Pine.LNX.4.33L.0108211141030.5646-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.GSO.4.33.0108211828150.6389-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2001, Rik van Riel wrote:
>I guess using an initrd on these 0.3% of machines shouldn't
>be too big a problem

Were's the initrd going to get the firmware?  It's not in the freakin' tree
anymore.  If I have to go download a firmware image and stick it in an
initrd, why the hell wouldn't I just plug it directly into the kernel?
It's *my* kernel.

> compared to violating the GPL

Oh for the love of God, will you people stop drooling over the fucking GPL?
It's *firmware*... it's just a bunch of bits.  It's *not* a program the
kernel executes.  It's just data. (__init_data to be exact.)

> and adding
>to kernel bloat for everybody else.

One man's bloat is another man's functionality.  Besides, it's got a hell of
a lot of company.  Ask yourself, will you miss 128_K_ in a machine with a
fiber channel card in it?  It "bloats" the kernel for people using that
hardware -- machines that don't need it can release it.

--Ricky

(If Sun would get off their ass(es) and support firewire, I'd stop using linux
 all together.  And before some smartass says they do, point to the ohci and
 sbp-2 drivers on the Solaris 8 Sparc CD.)


