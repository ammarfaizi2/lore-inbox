Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310474AbSCBWgM>; Sat, 2 Mar 2002 17:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310475AbSCBWgD>; Sat, 2 Mar 2002 17:36:03 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:42352 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S310474AbSCBWfr>; Sat, 2 Mar 2002 17:35:47 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
Reply-To: "lm-sensors" <sensors@stimpy.netroedge.com>
Organization: LISA GmbH
To: Mike Fedyk <mfedyk@matchmail.com>, Theodore Tso <tytso@mit.edu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Dennis Jim <jdennis@snapserver.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Congrats Marcelo,
Date: Sat, 2 Mar 2002 23:35:18 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.21.0202281849450.2391-100000@freak.distro.conectiva> <20020228202803.A14374@thunk.org> <20020301015347.GE2711@matchmail.com>
In-Reply-To: <20020301015347.GE2711@matchmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020302223518.A2AE51578@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 1. March 2002 02:53, Mike Fedyk wrote:
> On Thu, Feb 28, 2002 at 08:28:03PM -0500, Theodore Tso wrote:
> > On Fri, Mar 01, 2002 at 12:01:51AM +0000, Alan Cox wrote:
> > > > Nope. I could well integrate lm_sensors in the future.
> > >
> > > Please be careful. lm_sensors can destroy machines if configured
> > > wrongly. Thats something that needs tackling - and ironically ACPI may
> > > actually solve that problem
> >
> > ... as in instant death for any modern Thinkpad laptops, requiring a
> > trip back to the factory and a replacement of the motherboard...
> >
> > *Please* don't integrate in lm_sensors without making sure the
> > thinkpad killing feature has been fixed.
>
> Or, just don't integrate that part of the patch...

The problem is nested deeper, I suspect.
When accessing the detected sensor on my toshiba 8100,
the automatic temperature control isn't working any longer...
Normally you can hear it starting every time, the cpu is under 
load.

Better you reboot quickly after that, with lm-sensors (2.62) disabled
then...

Details on request.

Cheers,
  Hans-Peter

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
