Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266030AbSKFSzG>; Wed, 6 Nov 2002 13:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266031AbSKFSzG>; Wed, 6 Nov 2002 13:55:06 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:19599 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S266030AbSKFSzF>; Wed, 6 Nov 2002 13:55:05 -0500
Date: Wed, 6 Nov 2002 19:58:06 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: John Levon <levon@movementarian.org>
cc: george anzinger <george@mvista.com>, Mikael Pettersson <mikpe@csd.uu.se>,
       Ingo Molnar <mingo@elte.hu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: NMI watchdog question.
In-Reply-To: <20021106181242.GA94146@compsoc.man.ac.uk>
Message-ID: <Pine.GSO.3.96.1021106195656.2684M-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2002, John Levon wrote:

> It seems that the test should be :
> 
> 	if (nmi_watchdog == NMI_IO_APIC) {
> 		... disable it
> 	}

 Indeed.  Good spotting.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

