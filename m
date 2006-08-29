Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964973AbWH2NxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbWH2NxP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 09:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWH2NxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 09:53:15 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:42462 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750833AbWH2NxO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 09:53:14 -0400
Subject: Re: [PATCH 2.6.18-rc4-mm2] fs/jfs: Conversion to generic boolean
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Richard Knutsson <ricknu-0@student.ltu.se>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, hch@infradead.org
In-Reply-To: <44F445A0.9000306@student.ltu.se>
References: <44F086E8.7090602@student.ltu.se>
	 <1156774979.7495.5.camel@kleikamp.austin.ibm.com>
	 <44F35537.6000308@student.ltu.se>
	 <1156799492.8732.19.camel@kleikamp.austin.ibm.com>
	 <44F37D4C.1080801@student.ltu.se>
	 <1156855062.8082.7.camel@kleikamp.austin.ibm.com>
	 <44F445A0.9000306@student.ltu.se>
Content-Type: text/plain
Date: Tue, 29 Aug 2006 08:53:11 -0500
Message-Id: <1156859592.8082.13.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-29 at 15:48 +0200, Richard Knutsson wrote:
> Dave Kleikamp wrote:
> 
> >On Tue, 2006-08-29 at 01:33 +0200, Richard Knutsson wrote:

> >>What do you say, can you hold on it for a while (can't be urgent, can 
> >>it?) and see how the conversion go. Will take time for it during this 
> >>week(end) and if the result is that almost no maintainer wants it, then...
> >>Just seem strange to having a boolean function but declaring it integer, 
> >>for (in my knowledge) no reason.
> >>    
> >>
> >
> >Sounds good to me.  I think I'll go ahead and kill the use of TRUE and
> >FALSE, but hold off on the type change for now.
> >  
> >
> To 0/1 or false/true?

I was going to go ahead with the 0/1 thing, but on second thought, I'll
just hold off on the whole thing and see where this ends up.  I may go
ahead and just accept your original patch.  We lived with the ugly,
locally-defined TRUE & FALSE this long.  Waiting a little longer can't
hurt.
-- 
David Kleikamp
IBM Linux Technology Center

