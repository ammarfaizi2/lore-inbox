Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbVFIPR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbVFIPR2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 11:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVFIPR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 11:17:28 -0400
Received: from styx.suse.cz ([82.119.242.94]:30153 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261891AbVFIPRV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 11:17:21 -0400
Date: Thu, 9 Jun 2005 17:17:16 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andrew Hutchings <info@a-wing.co.uk>
Cc: Francois Romieu <romieu@fr.zoreil.com>, linux-kernel@vger.kernel.org
Subject: Re: sis5513.c patch
Message-ID: <20050609151716.GA15597@ucw.cz>
References: <42A621BC.7040607@a-wing.co.uk> <20050607225755.GB30023@electric-eye.fr.zoreil.com> <42A62BD0.7090709@a-wing.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A62BD0.7090709@a-wing.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 12:20:48AM +0100, Andrew Hutchings wrote:
> Francois Romieu wrote:
> >Andrew Hutchings <info@a-wing.co.uk> :
> >[...]
> >
> >>I'm looking at trying to revive the old sis190.c net driver for this 
> >>board too, this does depend on my boss giving me some development time.
> >
> >
> >If you don't mind scary crashes, you can take a look at:
> >http://www.fr.zoreil.com/people/francois/misc/sis190-000.patch
> >
> >I have not been able to find a K8S-MX at the local retailers. It does
> >not help testing nor does it suggest that there is a strong need.
> >
> 
> Unfortunately I have been lumbered with 5 of these (insert rude word 
> here) boards and have had problems with pretty much every driver.  SATA 
> had to be download from SiS's website, PATA is as my patch (no idea why 
> a sis5513 driver wasn't coded to detect a sis5513).

Because your device definitely is not a 5513. 5513 is a very old chip
from the early pentium era and isn't produced anymore. SiS just didn't
bother to change the PCI IDs since then ...

That's why the driver does quite complex probing for the real type of
the chip.

> I used rev1.1 of 
> the sis190.c driver along with a guy from India, he says it works, I say 
> it doesn't (but it may be because my test network is 10Meg Half-Duplex). 
> Thank the heavens I am using this as a headless server, sound and 
> video are a nightmare as well apparently.
> 
> Many thanks for the link, boss is going on holiday next week so as long 
> as none of the servers melt down then I should be able to work on this.


-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
