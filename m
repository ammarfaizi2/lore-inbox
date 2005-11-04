Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbVKDWZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbVKDWZf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 17:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbVKDWZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 17:25:35 -0500
Received: from ip57.73.1311O-CUD12K-02.ish.de ([62.143.73.57]:38589 "EHLO
	metzlerbros.de") by vger.kernel.org with ESMTP id S1750881AbVKDWZe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 17:25:34 -0500
From: Ralph Metzler <rjkm@metzlerbros.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17259.57366.961190.594468@localhost.localdomain>
Date: Fri, 4 Nov 2005 23:26:30 +0100
To: Andreas Oberritter <obi@linuxtv.org>
Cc: Manu Abraham <manu@linuxtv.org>, linux-kernel@vger.kernel.org,
       Mike Krufky <mkrufky@linuxtv.org>, linux-dvb-maintainer@linuxtv.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [linux-dvb-maintainer] Re: [PATCH 26/37] dvb: add support for
	plls used by nxt200x
In-Reply-To: <1131065468.9376.23.camel@ip6-localhost>
References: <4367241A.1060300@m1k.net>
	<20051103135910.3bf893d9.akpm@osdl.org>
	<436A96A8.4080906@linuxtv.org>
	<436AA148.8090705@linuxtv.org>
	<1131065468.9376.23.camel@ip6-localhost>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Oberritter writes:
 > On Fri, 2005-11-04 at 03:46 +0400, Manu Abraham wrote:
 > > We have in the DVB subsystem most of the exported symbols as 
 > > EXPORT_SYMBOL itself, rather than EXPORT_SYMBOL_GPL. I think if this 
 > > needs to be changed, we would require a global change of all symbols to 
 > > the same to maintain consistency. If you require that change we can have 
 > > a change but i would think that the discussions be done with the 
 > > relevant copyright holders too, eventhough probably most of the authors 
 > > won't have any objection.
 > 
 > I don't know if I ever contributed code to the DVB subsystem which is
 > actually exported, but in case I did, then I am against changing the
 > affected EXPORT_SYMBOLs.
 > 
 > This would make it impossible to the use source code of most hardware
 > vendors for embedded products because they usually have different
 > licenses for their "run-on-every-embedded-platform-and-even-on-windows"
 > drivers.
 > 
 > Also I remember people telling on lkml that EXPORT_SYMBOL_GPL was used
 > for new kernel internal code only and I can't see how this applies to
 > dvb-pll or any other part of the dvb subsystem which grew up outside the
 > kernel tree.


AFAIK, the DVB core is also purposely using an LGPL license to allow
drivers with other licenses to at least use the DVB includes/calls.


Regards,
Ralph
