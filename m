Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262058AbRETP4d>; Sun, 20 May 2001 11:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262059AbRETP4X>; Sun, 20 May 2001 11:56:23 -0400
Received: from t2.redhat.com ([199.183.24.243]:4596 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262058AbRETP4N>; Sun, 20 May 2001 11:56:13 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010520114411.A3600@thyrsus.com> 
In-Reply-To: <20010520114411.A3600@thyrsus.com>  <20010518034307.A10784@thyrsus.com> <E150fV9-0006q1-00@the-village.bc.nu> <20010518105353.A13684@thyrsus.com> <3B053B9B.23286E6C@redhat.com> <20010518112625.A14309@thyrsus.com> <20010518113726.A29617@devserv.devel.redhat.com> <20010518114922.C14309@thyrsus.com> <8485.990357599@redhat.com> <20010520111856.C3431@thyrsus.com> <15823.990372866@redhat.com> 
To: esr@thyrsus.com
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: CML2 design philosophy heads-up 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 20 May 2001 16:56:10 +0100
Message-ID: <16267.990374170@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


esr@thyrsus.com said:
> There are no `advisory' dependencies in CML2.  They're all absolute.
> What you call an `advisory' dependency would be simulated by having a
> policy symbol for Aunt Tillie mode and writing constraints like this:

> require AUNT_TILLIE implies FOO >= BAR

> This is exactly why the CML2 ruleset has EXPERT, WIZARD, and TUNING
> policy symbols, as hooks for doing things like this.  

Excellent. Then I apologise for not reading the documentation.

After the discussion of MAC and SCSI config options many moons ago in this
thread, I was left with the impression that the constraints which were 
being objected to were not dependent upon a NOVICE mode, but were 
unconditional.

Was this merely a mistake in the conversion of the ruleset? Do you have a 
policy that the default behaviour should be similar to that of CML1, or at 
least that such behaviour should be available through one of the 
modes? If not, please consider doing so.

--
dwmw2


