Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129292AbRBVKeT>; Thu, 22 Feb 2001 05:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129975AbRBVKeJ>; Thu, 22 Feb 2001 05:34:09 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:22520 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129093AbRBVKdu>; Thu, 22 Feb 2001 05:33:50 -0500
Date: Thu, 22 Feb 2001 11:16:06 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Tigran Aivazian <tigran@veritas.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Burton Windle <burton@fint.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Detecting SMP
In-Reply-To: <Pine.LNX.4.21.0102211758290.2050-100000@penguin.homenet>
Message-ID: <Pine.GSO.3.96.1010222111316.2302A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2001, Tigran Aivazian wrote:

> So, one would normally expect this to mean an SMP board rather than
> multiple processors, _HOWEVER_, I can imagine a very clever MP-aware BIOS
> implementation which detects that there are many processors and prepares
> MP floating config table and does _not_ prepare it otherwise. So, it all
> depends on the BIOS implementation.

 I've seen systems that do so and while it's not forbidden I consider it a
bad thing.  It prevents us from being able to use I/O APICs.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

