Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129818AbRAZN4T>; Fri, 26 Jan 2001 08:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130816AbRAZN4J>; Fri, 26 Jan 2001 08:56:09 -0500
Received: from pizda.ninka.net ([216.101.162.242]:62097 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129818AbRAZNz7>;
	Fri, 26 Jan 2001 08:55:59 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14961.33191.626833.945221@pizda.ninka.net>
Date: Fri, 26 Jan 2001 05:54:47 -0800 (PST)
To: James Sutherland <jas88@cam.ac.uk>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
In-Reply-To: <Pine.SOL.4.21.0101261351150.11126-100000@red.csi.cam.ac.uk>
In-Reply-To: <14961.25754.449497.640325@pizda.ninka.net>
	<Pine.SOL.4.21.0101261351150.11126-100000@red.csi.cam.ac.uk>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


James Sutherland writes:
 > I was not suggesting ignoring these. OTOH, there is no reason to treat an
 > RST packet as "go away and never ever send traffic to this host again" -
 > i.e. trying another TCP connection, this time with ECN disabled, would be
 > acceptable.

The connection failed, RST means connection reset.  RST means all
state is corrupt and this connection must die.  It cannot be
interpreted in any other way.

Using it as a metric for ECN enabling is thus unacceptable.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
