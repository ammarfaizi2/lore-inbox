Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265144AbUFHAcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbUFHAcT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 20:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265141AbUFHAcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 20:32:19 -0400
Received: from bhhdoa.org.au ([216.17.101.199]:3592 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S265144AbUFHAcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 20:32:02 -0400
Message-ID: <1086646115.40c4e763687e4@vds.kolivas.org>
Date: Tue,  8 Jun 2004 08:08:35 +1000
From: Con Kolivas <kernel@kolivas.org>
To: Phy Prabab <phyprabab@yahoo.com>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH] Staircase Scheduler v6.3 for 2.6.7-rc2
References: <20040608000650.81972.qmail@web51810.mail.yahoo.com>
In-Reply-To: <20040608000650.81972.qmail@web51810.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Phy Prabab <phyprabab@yahoo.com>:

> 
> Just to clarify, setting compute 1 implys interactive
> 0?

Yes.

> 
> These numbers are very reproducable nad have done them
> (in a continuous loop) for two hours.

Ok.

> 
> The test is a make of headers for a propritary exec. 
> Making headers is rather simple is all it does it link
> a bunch of h files (traversing dirs) and some
> dependance generation (3 files, yacc and lex).  I have
> moved the source code base to local disk to dicount
> nfs issues (though the difference is neglibible and
> nfs performance on 2.6 is generally faster than 2.4).

Out of curiosity, what happens from nfs? i/o effects can be significant. I
assume you've excluded memory effects?

> I have tried to get a good test case that can be
> submitted. Still trying. 

Linking kernel headers with full debugging?

> Any suggestions to try to diagnose this?

Profiling.

> Thanks!
> Phy

Cheers,
Con
