Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264493AbTLVPeq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 10:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264536AbTLVPeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 10:34:46 -0500
Received: from shadow02.cubit.at ([80.78.231.91]:52876 "EHLO
	skeletor.netshadow.at") by vger.kernel.org with ESMTP
	id S264493AbTLVPek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 10:34:40 -0500
Subject: Re: /proc/meminfo values
From: Andreas Unterkircher <unki@netshadow.at>
Reply-To: unki@netshadow.at
To: Rob Love <rml@ximian.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1072107066.3318.17.camel@fur>
References: <1072104601.1165.33.camel@winsucks>
	 <1072107066.3318.17.camel@fur>
Content-Type: text/plain
Message-Id: <1072107278.1165.36.camel@winsucks>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 22 Dec 2003 16:34:38 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, den 22.12.2003 schrieb Rob Love um 16:31:
> On Mon, 2003-12-22 at 09:50, Andreas Unterkircher wrote:
> 
> > cat /proc/meminfo
> >         total:    used:    free:  shared: buffers:  cached:
> > Mem:  244191232 238395392  5795840        0  2732032 138403840
> > Swap: 509923328 147443712 362479616
> 
> This view is gone.  Use something like free(1) or a custom script to
> recreate it.
> 
> > but with 2.6 it looks like they have been removed. where can i get the
> > exactly free memory (+ swap) from the kernel so i havn't to use the
> > kb-values which i get back from /proc/meminfo?
> > 
> > i try to check the source good from "free" (with the -b option it
> > returns the bytes-value) which seems to simple multiply *1024 to
> > the kb values.
> 
> But everything is page granularity already, which is 4KB on x86.  Going
> to bytes would not gain you anything.

Ok, i'm unterstand :) I will simple multiply the proc values with 1024
when i want to use them with the cricket-snmp-collector. this seems to
be exactly enough - i only want to know - thanks rob and rik for the
info!

greetings, andi

> 
> 	Rob Love
> 
> 

