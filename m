Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277336AbRJJRgE>; Wed, 10 Oct 2001 13:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277337AbRJJRfy>; Wed, 10 Oct 2001 13:35:54 -0400
Received: from eispost12.serverdienst.de ([212.168.16.111]:49415 "EHLO imail")
	by vger.kernel.org with ESMTP id <S277336AbRJJRfl>;
	Wed, 10 Oct 2001 13:35:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Robert Szentmihalyi <robert.szentmihalyi@entracom.de>
To: Chmouel Boudjnah <chmouel@mandrakesoft.com>,
        Juan Quintela <quintela@mandrakesoft.com>
Subject: Re: APM on a HP Omnibook XE3
Date: Wed, 10 Oct 2001 19:36:00 +0200
X-Mailer: KMail [version 1.3]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200108301443355.SM00167@there> <m2elobn7a3.fsf@anano.mitica> <m3sncrh9u8.fsf@giants.mandrakesoft.com>
In-Reply-To: <m3sncrh9u8.fsf@giants.mandrakesoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200110101943880.SM00161@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 10. Oktober 2001 16:02 schrieb Chmouel Boudjnah:
> Juan Quintela <quintela@mandrakesoft.com> writes:
> > >>>>> "robert" == Robert Szentmihalyi
> > >>>>> <robert.szentmihalyi@entracom.de> writes:
> >
> > robert> Hi!
> > robert> Sorry if this is OT.
> > robert> I'm not sure if this is a kernel issue, but I'm running
> > out of robert> ideas on this....
> >
> > robert> I have a HP Omnibook XE3 with SuSE Linux 7.2 installed.
> > robert> Everything works fine except suspend-to-disk.
> > robert> (I have created the partition. It works under
> > Winblows...) robert> I have tried Kernels 2.4.4 and 2.4.7 (with
> > SuSE patches) as well as robert> 2.4.9 vanilla, but I keep
> > getting the same messages: robert> When I do
> > robert> apm -s
> > robert> I get
> > robert> apm: Input/output error
> > robert> and the Kernel log says:
> > robert> apm: suspend: Unable to enter requested state
> >
> >
> > robert> Any ideas what I could do?
> >
> > For me Fn+F12 works.
unfortunately not for me....
> > apm -s & apm -S fails.
>
> works only if you have a suspend-on-disk partition.
I have created one with lphdisk and it works under Win2k...

The HP support people say the new omnibook BIOS is not APM 
compilant any more.
ACPI only...

Suspend-to-disk with API is not yet supported and I can't use 
software suspend because of reiserfs

I guess I have to wait for proper hibernation support with ACPI....

-- 
Where do you want to be tomorrow?

Entracom. Building Linux systems.
http://www.entracom.de
