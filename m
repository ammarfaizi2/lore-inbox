Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129807AbQLXVO4>; Sun, 24 Dec 2000 16:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129965AbQLXVOr>; Sun, 24 Dec 2000 16:14:47 -0500
Received: from 216-80-74-178.dsl.enteract.com ([216.80.74.178]:4100 "EHLO
	kre8tive.org") by vger.kernel.org with ESMTP id <S129807AbQLXVOe>;
	Sun, 24 Dec 2000 16:14:34 -0500
Date: Sun, 24 Dec 2000 14:43:29 -0600
From: Mike Elmore <mike@kre8tive.org>
To: linux-kernel@vger.kernel.org
Subject: [mwelmor@kre8tive.org: Masquerade hangups]
Message-ID: <20001224144329.A15680@lingas.basement.bogus>
Reply-To: mike@kre8tive.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK.  I went back to 2.2.18 (released) and things
work better.

Since it appears the debug flags don't work in the
8139too module, how can I turn on some debug flags
in the 2.4.0-test13-pre4 driver so I can see where
this thing is hanging?


-mwe




----- Forwarded message from Mike Elmore <mwelmor@kre8tive.org> -----

Date: 	Sun, 24 Dec 2000 09:02:12 -0600
From: Mike Elmore <mwelmor@kre8tive.org>
To: linux-kernel@vger.kernel.org
Subject: Masquerade hangups
User-Agent: Mutt/1.2.5i
Precedence: bulk
X-Mailing-List: 	linux-kernel@vger.kernel.org

Hello,

I have a Tyan S1854 Trinity 400 mb machine with a
PCI rtl8139 card connected to my local net and a
ISA 3c509 card connected to my dsl link.  Masquerade
is set up.

I seem to get pretty good performance from 
internet->masq box and from masq box->internal
lan, but when a internal box tries to get to the
net through the masquerade, connection seem to time
out.  I'll get a pretty good initial burst, then
connections stall.

I'm using test13-pre4.  I saw some iptables stuff on
the list a week or so ago, was this fixed in pre4 or
is this my problem?

I can provide any information needed.

-mwe
mike@kre8tive.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

----- End forwarded message -----

-- 


Mike Elmore
mike@kre8tive.org

"Never confuse activity with accomplishment."
				-unknown

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
