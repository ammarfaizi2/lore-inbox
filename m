Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263943AbUFPOob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263943AbUFPOob (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 10:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263944AbUFPOob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 10:44:31 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:4540 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S263943AbUFPOo3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 10:44:29 -0400
Subject: Re: IPMI hangup in 2.6.6-rc3
From: Alex Williamson <alex.williamson@hp.com>
To: Corey Minyard <minyard@acm.org>
Cc: Holger Kiehl <Holger.Kiehl@dwd.de>,
       Philipp Matthias Hahn <pmhahn@titan.lahn.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <40D05779.9080203@acm.org>
References: <Pine.LNX.4.58.R0405040649310.15047@praktifix.dwd.de>
	 <20040525165335.GA28905@titan.lahn.de>  <40C0E2BF.3040705@acm.org>
	 <1086887543.4182.46.camel@tdi>
	 <Pine.LNX.4.58.0406161225210.17908@praktifix.dwd.de>
	 <40D056E2.4010605@acm.org>  <40D05779.9080203@acm.org>
Content-Type: text/plain
Organization: LOSL
Message-Id: <1087397062.4274.3.camel@tdi>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 16 Jun 2004 08:44:22 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  That appears to do the trick on my rx8620:

ipmi message handler version v31
ipmi device interface version v31
IPMI System Interface driver version v31, KCS version v31, SMIC version
v31, BT version v31
ipmi_si: ACPI/SPMI specifies "bt" memory SI @ 0xffc30040000
ipmi_si: ipmi_si unable to claim interrupt 17, running polled
 IPMI bt interface initialized

I still can't confirm whether or not the interface works, but this is
definitely better than before.  Thanks,

	Alex


On Wed, 2004-06-16 at 08:21, Corey Minyard wrote:
> I missed a part of the patch, here is a new one with the include file 
> changes.
> 
> -Corey
> 
> Corey Minyard wrote:
> 
> > Unfortuantely, that fix has some problems, but it was on the right 
> > track.  I have a new patch attached; can you try it out?  Also, the 
> > kernel interface has not changed.  It should be exactly the same as 
> > before.
> >
> > -Corey
> 
> 
> ______________________________________________________________________


