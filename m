Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264565AbTIJFfh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 01:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264634AbTIJFfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 01:35:36 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:34310 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S264565AbTIJFff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 01:35:35 -0400
To: Matthew Wilcox <willy@debian.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Ralf Baechle <ralf@gnu.org>, Richard Henderson <rth@twiddle.net>
Subject: Re: [PATCH] Move EISA_bus
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
References: <20030909222937.GH18654@parcelfarce.linux.theplanet.co.uk>
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: Wed, 10 Sep 2003 07:31:23 +0200
Message-ID: <wrpbrttyztg.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <20030909222937.GH18654@parcelfarce.linux.theplanet.co.uk> (Matthew
 Wilcox's message of "Tue, 9 Sep 2003 23:29:37 +0100")
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Matthew" == Matthew Wilcox <willy@debian.org> writes:

Matthew> While I'm at it, I also move the variable definition to
Matthew> drivers/eisa/eisa-bus.c.  The rest of this patch is fixing up
Matthew> the fallout from having to include <linux/eisa.h> if you use
Matthew> EISA_bus.

Yup.

While we're at it, why not setting EISA_bus as 'deprecated', so people
will know they'd better move the driver to the EISA probing API ?

     M.
-- 
Places change, faces change. Life is so very strange.
