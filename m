Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136950AbRA1I4w>; Sun, 28 Jan 2001 03:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136969AbRA1I4n>; Sun, 28 Jan 2001 03:56:43 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:32911 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S136968AbRA1I40>; Sun, 28 Jan 2001 03:56:26 -0500
Date: Sun, 28 Jan 2001 08:56:09 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: jamal <hadi@cyberus.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: ECN: Clearing the air (fwd)
In-Reply-To: <Pine.GSO.4.30.0101271914000.24762-100000@shell.cyberus.ca>
Message-ID: <Pine.SOL.4.21.0101280852470.14226-100000@green.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sure we all know what the IETF is, and where ECN came from. I haven't
seen anyone suggesting ignoring RST, either: DM just imagined that,
AFAICS.

The one point I would like to make, though, is that firewalls are NOT
"brain-damaged" for blocking ECN: according to the RFCs governing
firewalls, and the logic behind their design, blocking packets in an
unknown format (i.e. with reserved bits set) is perfectly legitimate. Yes,
those firewalls should be updated to allow ECN-enabled packets
through. However, to break connectivity to such sites deliberately just
because they are not supporting an *experimental* extension to the current
protocols is rather silly.


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
