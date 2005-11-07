Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbVKGJiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbVKGJiW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 04:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbVKGJiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 04:38:22 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:3855 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S932469AbVKGJiV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 04:38:21 -0500
Date: Mon, 7 Nov 2005 09:38:21 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Andi Kleen <ak@suse.de>
Cc: Zachary Amsden <zach@vmware.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14: CR4 not needed to be inspected on the 486 anymore?
In-Reply-To: <p73fyqb2dtx.fsf@verdi.suse.de>
Message-ID: <Pine.LNX.4.55.0511070931560.28165@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.55.0511031600010.24109@blysk.ds.pg.gda.pl>
 <436A3C10.9050302@vmware.com> <Pine.LNX.4.55.0511031639310.24109@blysk.ds.pg.gda.pl>
 <436AA1FD.3010401@vmware.com> <p73fyqb2dtx.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Nov 2005, Andi Kleen wrote:

> I don't think it's a good idea. Relying on nested faults in oops
> is a bit unsafe because it could lead to recursive faults in the worst case. 

 Good point.

> Better keep the if

 Except the condition is wrong.  Presence of CR4 could be tested elsewhere
though, with the result being the condition here.

  Maciej
