Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136740AbRATIqP>; Sat, 20 Jan 2001 03:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137190AbRATIqG>; Sat, 20 Jan 2001 03:46:06 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:10500
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S136740AbRATIpx>; Sat, 20 Jan 2001 03:45:53 -0500
Date: Sat, 20 Jan 2001 00:45:33 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "H. Peter Anvin" <hpa@transmeta.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Minors remaining in Major 10 ??
Message-ID: <Pine.LNX.4.10.10101200039590.609-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


HPA,

Thoughts on granting all block subsystems a general access misc-char minor
to do special service access that can not be down to a given device if it
is open.  There are some things you can not do to a device if you are
using its device-point to gain entry.  Also do the grab a neighboor and
force the migration to find the desired major/minor is painful.

Cheers,

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
