Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947271AbWKKTQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947271AbWKKTQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 14:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946270AbWKKTQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 14:16:56 -0500
Received: from khc.piap.pl ([195.187.100.11]:35043 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1947271AbWKKTQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 14:16:55 -0500
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Stephen Hemminger <shemminger@osdl.org>,
       Jesper Juhl <jesper.juhl@gmail.com>, Al Boldi <a1426z@gawab.com>,
       linux-kernel@vger.kernel.org
Subject: Re: A proposal; making 2.6.20 a bugfix only version.
References: <200611090757.48744.a1426z@gawab.com>
	<20061109090502.4d5cd8ef@freekitty>
	<200611101852.14715.a1426z@gawab.com>
	<9a8748490611100816v573418f4gcd5cbe34d0dd3715@mail.gmail.com>
	<4554AC12.6040407@osdl.org>
	<20061110085311.54fd65f2.rdunlap@xenotime.net>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 11 Nov 2006 20:16:53 +0100
In-Reply-To: <20061110085311.54fd65f2.rdunlap@xenotime.net> (Randy Dunlap's message of "Fri, 10 Nov 2006 08:53:11 -0800")
Message-ID: <m3odrdiyje.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@xenotime.net> writes:

>>   * LKML is an overloaded communication channel, do we need:
>>       linux-bugs@vger.kernel.org ?

Not sure if LKML is overloaded - subject filtering etc. And people
expect they will be Ccopied if they are, for example, maintainers.

It's not the list for everybody, though.

> Either that or lkml is/remains for bug reporting and we move development
> somewhere else.  Or my [repeated] preference:
>
> do development on specific mailing lists (although there would
> likely need to be a fallback list when it's not clear which mailing
> list should be used)

I don't like this idea as implemented now - it's probably fine for
subsystem maintainers but it's prohibitive for an occasional submitter.


But... specific lists would make sense if - and only if:
- they are always mirrored to something like LKML so one doesn't need
  to subscribe to every possible list (as they appear).
- they are open as LKML is (no specific subscription required to post)

This way one could discuss things with/on a specific list (subscribed
by subsystem maintainers and other interested people) and everyone
reading the general list (or more general?) would see it too.

We could have a hierarchy:
- specific lists like lmkl-usb-ohci
- more general lkml-usb
- lkml, seeing all mail

This way every mail sent to lkml-usb-ohci would be sent to lkml-usb,
and lkml-usb would be copied to lkml as well (I imagine some duplicate
elimination would be a plus).

Anyone could discuss ohci writing to lkml-usb-ohci, discuss general
USB writing to lkml-usb etc. Anyone subscribed to any of the above
lists would see the traffic they are interested in, without a need
for constant subscribing.

I assume the lists would be hosted on one domain to make it easy
to post and perhaps to enable it to work at all.

If some form of sender address verification/scoring was in use I think
it would be smart to recognize all people subscribed to more general
lists to be "known" for this purpose (i.e., people subscribed to
lkml would be considered "subscribed" while posting to lkml-usb-ohci).


Having written all of the above I now like the idea so be prepared to
fight me hard if you don't :-)
Perhaps I could even help implementing it in some unspecified so
called "free time".
-- 
Krzysztof Halasa
