Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWI2L7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWI2L7p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 07:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWI2L7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 07:59:45 -0400
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:41659 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751235AbWI2L7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 07:59:44 -0400
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Neil Brown <neilb@suse.de>, tridge@samba.org,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
References: <1159498900.3880.31.camel@mulgrave.il.steeleye.com>
	<17692.41932.957298.877577@cse.unsw.edu.au>
	<17692.41932.957298.877577@cse.unsw.edu.au>
	<1159512998.3880.50.camel@mulgrave.il.steeleye.com>
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Date: 29 Sep 2006 12:59:42 +0100
In-Reply-To: <1159512998.3880.50.camel@mulgrave.il.steeleye.com>
Message-ID: <r6zmciopch.fsf@skye.ra.phy.cam.ac.uk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> writes:
> I'm asserting that producing something (an appliance say, or a PCI
> card) that runs linux to achieve its function is a "use" (an act of
> running the program) within the meaning of GPLv2 clause 0.  Selling
> the Box (or card, or whatever) also becomes a distribution.

The vendor did many acts covered by copyright law (taking US copyright
law here), and it's important to distinguish the effects of the
license on each act:

1. Use: Vendor runs Linux on prototype hardware to see where it fails
   to boot, in order to write new drivers.  The GPL places no
   restriction on this act, and probably cannot do so since US
   copyright law doesn't cover running a program.

2. Prepare a derivative work: Vendor writes drivers for their
   hardware, builds a new Linux kernel.  The GPLv2 places no
   restriction on this act.  The GPLv3 restricts this act a bit in the
   patent retaliation clause.

3. Use the derivative work: Vendor tests (runs) the modified Linux.
   There are no restrictions placed by the GPL (v2 or v3).  If you can
   make the derivative work (e.g. don't fall foul of the
   patent-retaliation clause in GPLv3), then you can use it how you
   want.

4. Distribute the derivative work: Vendor sells the hardware with
   embedded Linux.  Now the GPL places restrictions.  v2 says that if
   you distribute, you must make source code available and (if I
   understand Alan Cox's argument correctly) make the installation
   keys available.  v3 tightens the installation-keys requirement.
   But it's not a use restriction.

> However I claim that, the GPLv3 requirement that you be able to "execute
> modified versions from source code in the recommended or principal
> context of use" does constitute an end use restriction on the embedded
> system because the appliance (or card, or whatever) must be designed in
> such a way as to allow this.

Not necessarily.  If the vendor makes devices for internal use, they
are not distributing the kernel, so no GPL requirements (except
perhaps the GPLv3 patent retaliation clause) are triggered.  Only when
they distribute does the GPL place requirements on what they must do:
provide source code and installation keys.  So it's not the use that
is restricted (they can do what they like 'at home'), only the
distribution.

Regards,
-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
