Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318743AbSHAMz5>; Thu, 1 Aug 2002 08:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318741AbSHAMz5>; Thu, 1 Aug 2002 08:55:57 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:9711 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318743AbSHAMzz>; Thu, 1 Aug 2002 08:55:55 -0400
Subject: Re: Linux 2.4.19ac3rc3 on IBM x330/x340 SMP - "ps" time skew
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Lincoln Dale <ltd@cisco.com>, David Luyer <david_luyer@pacific.net.au>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200208010133.g711Xq7338295@saturn.cs.uml.edu>
References: <200208010133.g711Xq7338295@saturn.cs.uml.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 Aug 2002 15:15:04 +0100
Message-Id: <1028211304.14865.36.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-01 at 02:33, Albert D. Cahalan wrote:
> > HZ on x86 is 100 by default.
> > that isn't 100 per CPU, but 100 per second, regardless of whether the timer 
> > interrupt is distributed between CPUs or serviced on a single CPU.
> 
> No shit. Now, how do you create a ps executable that handles
> a 2.4.xx kernel with a modified HZ value? People did this all

HZ in /proc is still 100 on a correctly modified 2.4 kernel. If people
can't get the modifications right it isnt your fault.


