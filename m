Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280107AbRKECLJ>; Sun, 4 Nov 2001 21:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280116AbRKECK7>; Sun, 4 Nov 2001 21:10:59 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13837 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280107AbRKECKp>; Sun, 4 Nov 2001 21:10:45 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: The PCI ID Repository
Date: 4 Nov 2001 18:10:22 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9s4see$egc$1@cesium.transmeta.com>
In-Reply-To: <20011104170202.A3370@ucw.cz> <200111050044.fA50i8o182130@saturn.cs.uml.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200111050044.fA50i8o182130@saturn.cs.uml.edu>
By author:    "Albert D. Cahalan" <acahalan@cs.uml.edu>
In newsgroup: linux.dev.kernel
> 
> Tundra provides an example: Universe, Universe II, Universe IIB
> 
> These chips are the same device in some sense; they are all
> PCI-to-VME bridges. (damn popular too) The programming interface
> is incompatible, so they get different revisions. Tundra isn't
> alone in interpreting the PCI spec this way.
> 

Another interpretation, which seems pretty common (we use this one at
Transmeta, for example) is to treat the version ID as the "minor
revision" (indicating an upward compatible change) and the device ID
as the "major revision" (change this to indicate an incompatible
change in the programming interface.)

Unfortunately PCI doesn't have the very nice "compatible with" list
that ISAPnP has -- that, and the "human readable string" were very
useful features of the ISAPnP spec.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
