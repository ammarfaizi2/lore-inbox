Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262017AbSIPMN3>; Mon, 16 Sep 2002 08:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262027AbSIPMN3>; Mon, 16 Sep 2002 08:13:29 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:39058 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S262017AbSIPMN2>; Mon, 16 Sep 2002 08:13:28 -0400
Date: Mon, 16 Sep 2002 14:15:30 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: arysin@myrealbox.com, linux-kernel@vger.kernel.org
Subject: Re: turning off APIC
In-Reply-To: <200209160128.DAA04146@harpo.it.uu.se>
Message-ID: <Pine.GSO.3.96.1020916141244.23086C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Sep 2002, Mikael Pettersson wrote:

> Which APIC? local or I/O? Please be specific.
> "noapic" does not and never has had anything to do with the
> local APIC, only the I/O APIC. There is currently no kernel
> option for preventing the local APIC from being enabled if
> the kernel was built with local APIC support.

 Well, "nosmp" does exactly that for a SMP-capable kernel -- it could be
trivially reused for a UP-APIC configuration (the case is obscure enough
not to invent another option). 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

