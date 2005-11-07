Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbVKGRLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbVKGRLO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbVKGRLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:11:13 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:16137 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S932296AbVKGRLM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:11:12 -0500
Date: Mon, 7 Nov 2005 17:11:18 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14: CR4 not needed to be inspected on the 486 anymore?
In-Reply-To: <436F8601.4070201@vmware.com>
Message-ID: <Pine.LNX.4.55.0511071655390.28165@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.55.0511031600010.24109@blysk.ds.pg.gda.pl>
 <436A3C10.9050302@vmware.com> <Pine.LNX.4.55.0511031639310.24109@blysk.ds.pg.gda.pl>
 <436AA1FD.3010401@vmware.com> <p73fyqb2dtx.fsf@verdi.suse.de>
 <Pine.LNX.4.55.0511070931560.28165@blysk.ds.pg.gda.pl> <436F7673.5040309@vmware.com>
 <Pine.LNX.4.55.0511071632110.28165@blysk.ds.pg.gda.pl> <436F8601.4070201@vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2005, Zachary Amsden wrote:

> Because I hold in my hand "i486 Microprocessor Programmer's Reference 
> Manual, c 1990", and it has no mention whatsoever of CR4, and all 

 Ah, that's too old.  Severely.  By definition it can only cover the
original i486, perhaps even only before the i486SX has been released (and
the original renamed to the i486DX).

> documentation I had until Friday had either no mention of CR4, or 

 You've had to have the right bits of documentation -- Intel has been
quite precise about presence or absence of these bits in given members of
the i486 family, but you've had to check specifically each datasheet and
yes, there was a separate one for each member up till the grand merge in
1995 or so, when model specifics became chapters of the combined spec
("Intel486 Processor Family Developer's Manual" or something like that).  
I still own the pile of printed books, including the latter, but not
easily accessible anymore.

> something to the effect of "new on Pentium, the CR4 register ..."  So 
> I've had to re-adjust my definition of 486, which was weird.

 Note that the workstation version of the i486 continued to evolve up to
around 1995, IIRC, and unsurprisingly got some updates "from upstream".
;-)

  Maciej
