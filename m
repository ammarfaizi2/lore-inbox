Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311670AbSDDVzP>; Thu, 4 Apr 2002 16:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311701AbSDDVzF>; Thu, 4 Apr 2002 16:55:05 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57611 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311670AbSDDVyz> convert rfc822-to-8bit; Thu, 4 Apr 2002 16:54:55 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: HomePlug support?
Date: 4 Apr 2002 13:54:21 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a8ii2d$j82$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10204041011210.309-100000@www.transvirtual.com> <20020404184048.GI435@turbolinux.com> <20020404222615.A13351@xyzzy.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id g34LsNN04864
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020404222615.A13351@xyzzy.org.uk>
By author:    Bob Dunlop <bob.dunlop@xyzzy.org.uk>
In newsgroup: linux.dev.kernel
>
> On Thu, Apr  4,  Andreas Dilger wrote:
> > On Apr 04, 2002  10:12 -0800, James Simmons wrote:
> > > Anyone working on HomePlug support?
> 
> As someone else has already responded.  Closed source standard so I'd guess
> unlikely to become a true standard.  Seen many variations before and they've
> all crashed and burned.  Whatever happened to the NorWEB field trial ?
> 
> > Hmm, I wonder if I will be able to run tcpdump from my electrical outlet
> > and listen to my neighbour's network traffic, and take over their X10
> > appliance controls ;-).
> 
> More interesting could you hack into the protocol for reading the electricty
> meter remotely ?  Spoof the meter and save a fortune in power bills!
> Worked nextdoor to a remote meter company once and it was a problem they
> took very seriously.

Encryption?

> Still puzzled by the European political standardisation of the power supply.
> Politics says 230V yet my AVO still reads 240V RMS in the UK and 220V in
> Germany ?  Still it also says 50Hz and I'd swear I only get 49 and a glitch.

The formal spec is something like 230 V ± 10%.  The value 230 V was
chosed exactly because both the 220 V and 240 V mains systems could
comply without change as long as they regulated their voltages more
tightly than the spec required.  Since the main reason for the fairly
wide error bar isn't variation in generation, but remote locations
with long transmission lines (how much voltage drop between the
nearest and the farthest tap?), this is mostly a non-issue.  It might
have required adjusting transformers in a few places that serve just
such remote locations, or the installation of buck/boost transformers
in a few places.  In urban areas it should have made absolutely no
difference.  Maybe they'll start using 230 V for new installations,
but somehow I doubt it.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
