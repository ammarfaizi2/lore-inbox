Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129332AbQKDCdj>; Fri, 3 Nov 2000 21:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129164AbQKDCd3>; Fri, 3 Nov 2000 21:33:29 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:8875 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129033AbQKDCdN>; Fri, 3 Nov 2000 21:33:13 -0500
Message-ID: <3A03753F.548324A9@linux.com>
Date: Fri, 03 Nov 2000 18:32:31 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: tytso@mit.edu, linux-kernel@vger.kernel.org, jeremy@goop.org,
        "David S. Miller" <davem@redhat.com>, rgooch@atnf.csiro.au,
        sct@redhat.com
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
In-Reply-To: <200011031509.eA3F9V719729@trampoline.thunk.org> <3A033A45.D8F6E952@mandrakesoft.com>
Content-Type: multipart/mixed;
 boundary="------------82B6A66CE5CCFE5F82E2A0EB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------82B6A66CE5CCFE5F82E2A0EB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:

> >      * 2.4.0-test8 pcmcia is unusable in fall forms (kernel, mixed, or
> >        dhinds code) (David Ford)
>
> "fall forms"?
>
> David clearly has problems w/ pcmcia, but it is not at all as broken as
> he makes it out to be:  all my cardbus laptops boot and work.
>
>
> >      * PCMCIA/Cardbus hangs (Basically unusable - Hinds pcmcia code is
> >        reliable)
>
> Again "whatever".  The CardBus code is definitely usable.  It is not
> mature, but saying it is "basically unusable" is wildly inaccurate.

The qualifiers I reported are not included above so don't take it to mean
wide ranging.

I reported pcmcia in all forms was broken for test8 on -my hardware-.

Other kernels such as test10-prex that I'm on now are workable with dhinds
pcmcia.  I sent you all the requested information you asked for in several
forms.  The kernel's idea of the the sockets just doesn't work...again, on
-my hardware-.

It doesn't matter what voodoo you practice, all of the kernels in the last
year have been unable to drive -my hardware- in any sort of stable fashion.
Recent kernels just can't figure out IRQs for the sockets.

David's package works in all situations except for the combined ne2k/modem
that I reported earlier and the ray_cs in similar fashion.

For the second report, when the kernel did figure out IRQs for the sockets,
plugging in a card sometimes killed all software interrupts.  I.e. hardware
responded such as caps, screen blank/active etc, but no mouse or key events
made it past the kernel.  Unplugging a card or putting it in socket 0
normally caused a plethura of unending OOPSes or another hang on the
insertion.

Ted, please put my qualifier back in, "On this NEC Versa LX laptop", I don't
want my reports taken out of context. :)

-d


--
"The difference between 'involvement' and 'commitment' is like an
eggs-and-ham breakfast: the chicken was 'involved' - the pig was
'committed'."



--------------82B6A66CE5CCFE5F82E2A0EB
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
org:<img src="http://www.kalifornia.com/images/paradise.jpg">
adr:;;;;;;
version:2.1
email;internet:david@kalifornia.com
title:Blue Labs Developer
x-mozilla-cpt:;-12480
fn:David Ford
end:vcard

--------------82B6A66CE5CCFE5F82E2A0EB--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
