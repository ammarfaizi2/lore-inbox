Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317874AbSFSMuj>; Wed, 19 Jun 2002 08:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317875AbSFSMui>; Wed, 19 Jun 2002 08:50:38 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:45701 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S317874AbSFSMuh>; Wed, 19 Jun 2002 08:50:37 -0400
Date: Wed, 19 Jun 2002 14:47:43 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Robbert Kouprie <robbert@radium.jvb.tudelft.nl>
cc: "'Raphael Manfredi'" <Raphael_Manfredi@pobox.com>,
       "'Helge Hafting'" <helgehaf@aitel.hist.no>,
       linux-kernel@vger.kernel.org
Subject: RE: The buggy APIC of the Abit BP6
In-Reply-To: <004001c216dd$1d24f520$020da8c0@nitemare>
Message-ID: <Pine.GSO.3.96.1020619144446.15094G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2002, Robbert Kouprie wrote:

> Problem now is, in the ack_none function we only know about the
> (illegal) vector we are getting, and not about the interrupt we need to
> reset. Could there be some kind of link between these, so that
> kick_IO_APIC_irq can be called from there?

 You get an invalid vector delivered due to massive transmission errors at
the inter-APIC bus.  The errors are a serious hardware problem that cannot
and should not be fixed in software.

 I'm told getting a better PSU may help, though. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

