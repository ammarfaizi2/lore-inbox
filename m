Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264042AbTFILtc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 07:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264144AbTFILtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 07:49:31 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:412 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S264042AbTFILt3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 07:49:29 -0400
Date: Mon, 9 Jun 2003 13:57:58 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: "Brian J. Murrell" <brian@interlinx.bc.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: local apic timer ints not working with vmware: nolocalapic
In-Reply-To: <Pine.LNX.4.50.0306051352500.3503-100000@montezuma.mastecende.com>
Message-ID: <Pine.GSO.3.96.1030609135224.2806A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jun 2003, Zwane Mwaikambo wrote:

> >  You may have a valid SMP table and discrete local APICs (i82489DX) which
> > are not reported in CPU capability bits.  The "nolocalapic" option should
> > handle them, too.  Otherwise it would be a surprising inconsistency. 
> 
> Good point, out of interest, have you come across broken system like that? 

 So far I've met three users of i82489DX-based systems, two of whom helped
me making them work with 2.4.  So at least at the beginning of 2.4.x they
used to work; hopefully nothing has got broken since then (I try to
monitor changes, but without real hardware to do testing something might
have slipped in unnoticed).  I don't know if these people have kept
upgrading their kernels nor whether they still use the systems.  There
were no bug reports, either, which basically may mean anything. 

 Why do you consider the systems broken?

> Regardless i'll update the patch.

 Great!

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

