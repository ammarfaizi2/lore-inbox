Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbUDMMUb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 08:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263228AbUDMMUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 08:20:31 -0400
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:58836 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262972AbUDMMU3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 08:20:29 -0400
Date: Tue, 13 Apr 2004 14:20:28 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ross Dickson <ross@datscreative.com.au>
Cc: jgrimm2@us.ibm.com, linux-kernel@vger.kernel.org, phil.el@wanadoo.fr
Subject: Re: io_apic & timer_ack fix
In-Reply-To: <200404100337.21730.ross@datscreative.com.au>
Message-ID: <Pine.LNX.4.55.0404131412101.15949@jurand.ds.pg.gda.pl>
References: <200404100337.21730.ross@datscreative.com.au>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Apr 2004, Ross Dickson wrote:

>  > Was it determined that the fix was bogus? damaging? fixable? 
>  
> I thought the patch was OK with typos fixed.

 I consider it final.

> Thomas was tracking down C1 C2 etc states but I do not know the results of
> his search?
> http://marc.theaimsgroup.com/?l=linux-kernel&m=107972277920929&w=2
> Was it a problem only with one machine?

 The effect seems impossible, but I can't discuss with facts.  I need to
get at AMD processor documents to find out what are the conditions to
switch between the power-save states.  Perhaps this is yet another SMM 
bug.  E.g. the pair of PIC poll I/O accesses interacts with the SMM 
somehow.

 Unfortunately I lack time to dig into it right now -- perhaps someone 
else can do the research?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
