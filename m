Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262317AbVAEKtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262317AbVAEKtY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 05:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbVAEKtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 05:49:24 -0500
Received: from mail.scs.ch ([212.254.229.5]:45704 "EHLO mail.scs.ch")
	by vger.kernel.org with ESMTP id S262317AbVAEKtV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 05:49:21 -0500
Subject: Re: ptrace single-stepping change breaks Wine
From: Thomas Sailer <sailer@scs.ch>
To: Mike Hearn <mh@codeweavers.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, wine-devel@winehq.com, mingo@elte.hu,
       julliard@winehq.com
In-Reply-To: <1104873315.3557.87.camel@littlegreen>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
	 <200412311413.16313.sailer@scs.ch> <1104499860.3594.5.camel@littlegreen>
	 <200412311651.12516.sailer@scs.ch>  <1104873315.3557.87.camel@littlegreen>
Content-Type: text/plain
Organization: SCS
Date: Wed, 05 Jan 2005 11:43:26 +0100
Message-Id: <1104921806.7043.27.camel@kronenbourg.scs.ch>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-04 at 21:15 +0000, Mike Hearn wrote:
> Context: this is not about ptrace stuff, but rather Thomas Sailors

s/Sailor/Sailer/

> I'm afraid Alexandre has decided not to apply this patch (the ABI
> personality syscall). His reasoning is as follows:

Quite understandably.

> Could you upload a +relay,+tid,+seh,+msgbox trace somewhere please? Of
> course if you could investigate it yourself that'd be the best thing.

http://www.baycom.org/~tom/wine/wine.xst.broken.relay.tid.seh.msgbox.gz
http://www.baycom.org/~tom/wine/wine.xst.working.relay.tid.seh.msgbox.gz

I used 2.6.10-ac1 and wine-20041201-1fc3winehq. The second log (which is
huge!, ~250MBytes compressed, compression ratio roughly 1:100) is with
setarch i386 -L.

Thanks,
Tom


