Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129439AbRBEKoz>; Mon, 5 Feb 2001 05:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129504AbRBEKop>; Mon, 5 Feb 2001 05:44:45 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:19937 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129912AbRBEKof>; Mon, 5 Feb 2001 05:44:35 -0500
Date: Mon, 5 Feb 2001 11:19:05 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
cc: Frank de Lange <frank@unternet.org>, linux-kernel@vger.kernel.org
Subject: Re: hard crashes 2.4.0/1 with NE2K stuff
In-Reply-To: <20010203113604.A625@grobbebol.xs4all.nl>
Message-ID: <Pine.GSO.3.96.1010205111436.18067A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Feb 2001, Roeland Th. Jansen wrote:

> I have sysrq'd twice. the first one is the one where it works, then,
> after a floodping of only 5 seconds, eth0 stops working. the floodping
> is generated from outside towards this machine. then again I sysrq'd/
> here are the results. I glued dmesg from begin to end so that all
> messages are visible from boot time. pls explain what you find :-)

 The I/O APIC still sends an edge-triggered interrupt resulting in a
lockup, sigh.  This is already being discussed in another thread. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
