Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285618AbSBSSUb>; Tue, 19 Feb 2002 13:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285692AbSBSSUV>; Tue, 19 Feb 2002 13:20:21 -0500
Received: from [208.29.163.248] ([208.29.163.248]:56535 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S285618AbSBSSUF>; Tue, 19 Feb 2002 13:20:05 -0500
Date: Tue, 19 Feb 2002 10:18:28 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: bert hubert <ahu@ds9a.nl>
cc: Jim Roland <jroland@roland.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Kernel ethernet alias limit
In-Reply-To: <20020219131121.A6383@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.44.0202191015280.6690-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if you use the new ip tools you can alias a large entblock in a single
command, but even with ifconfig you can do a lot (I have one machine with
>1770 ipaddresses assigned via ifconfig with no problem)

David Lang

 On Tue, 19 Feb 2002, bert hubert wrote:

> Date: Tue, 19 Feb 2002 13:11:21 +0100
> From: bert hubert <ahu@ds9a.nl>
> To: Jim Roland <jroland@roland.net>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Kernel ethernet alias limit
>
> On Tue, Feb 19, 2002 at 09:39:30AM +0000, Jim Roland wrote:
> > I seem to remember back in either Kernel 2.0 or 2.2 there was a limit of 256
> > aliases within the ethX aliasing (eg, eth0, then eth0:0 thru eth0:255).
> >
> > Has the limit on this been expanded with Kernel 2.4, is it stable and/or
> > advised?  I have a need to bind more than 256 addresses to a single
> > interface.  Without installing additional network cards.
>
> Use a loopback interface - you can easily bind to a /8 if you want this way.
>
> I think this is documented in the 'ip' documentation in 'iproute2' from
> Alexey. It has also been explained on list here.
>
> Regards,
>
> bert
>
> --
> http://www.PowerDNS.com          Versatile DNS Software & Services
> http://www.tk                              the dot in .tk
> Netherlabs BV / Rent-a-Nerd.nl           - Nerd Available -
> Linux Advanced Routing & Traffic Control: http://ds9a.nl/lartc
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
