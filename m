Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbVBASzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVBASzs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 13:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVBASzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 13:55:48 -0500
Received: from orb.pobox.com ([207.8.226.5]:16307 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261409AbVBASzn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 13:55:43 -0500
Subject: Re: [ANN] removal of certain net drivers coming soon:
	eepro100,?xircom_tulip_cb, iph5526
From: Scott Feldman <sfeldma@pobox.com>
Reply-To: sfeldma@pobox.com
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOC.4.61.0502011444310.26768@math.ut.ee>
References: <E1CuSUy-00063X-LK@rhn.tartu-labor>
	 <1106939504.18167.364.camel@localhost.localdomain>
	 <Pine.SOC.4.61.0502011444310.26768@math.ut.ee>
Content-Type: text/plain
Message-Id: <1107284234.3366.95.camel@sfeldma-mobl.dsl-verizon.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 01 Feb 2005 10:57:14 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-01 at 04:48, Meelis Roos wrote:
> > See if eepro100 works on your 82556 cards.  I would be surprised if it
> > does.  If it does, maybe it's not that much trouble to add support to
> > e100.  Let us know.
> 
> I did add the PCI ID to e100 to to try it with both drivers.
> 
> In short: both eepro100 and e100 have problems loading the eeprom and 
> don't work at least out of the box.

Thanks Meelis.

I'll send a patch to Jeff to remove 82556 support from eepro100 for now,
just in case eepro100 sticks around longer.  I believe it was a mistake
to add it in the first place.  82556 support should not be in there.

-scott

