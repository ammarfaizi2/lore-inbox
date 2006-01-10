Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWAJSdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWAJSdV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 13:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbWAJSdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 13:33:21 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:52607 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750804AbWAJSdU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 13:33:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j1ANP557rRZvqYZEuEbEjoiJBTCRt0ITDSNr7uYptOEnFYVnQ5m8XjIRjQZmDiSPWhYxFVxmpcLhb8PvqDR0RNbzaANQ81hWrkVey9SdP6Nq3XfShu2VnLNtoocclQb5XwqFJNX/4Ia4tdDwK/3NHymqMwnS6PSxVS4pU/tz+fg=
Message-ID: <2cd57c900601101033i5ee2990m@mail.gmail.com>
Date: Tue, 10 Jan 2006 18:33:15 +0000
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2G memory split
Cc: Mark Lord <lkml@rtr.ca>, Jens Axboe <axboe@suse.de>,
       Byron Stanoszek <gandalf@winds.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601100851390.4939@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060110125852.GA3389@suse.de> <20060110132957.GA28666@elte.hu>
	 <20060110133728.GB3389@suse.de>
	 <Pine.LNX.4.63.0601100840400.9511@winds.org>
	 <20060110143931.GM3389@suse.de>
	 <Pine.LNX.4.64.0601100804380.4939@g5.osdl.org>
	 <43C3E376.3020303@rtr.ca>
	 <Pine.LNX.4.64.0601100851390.4939@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/1/10, Linus Torvalds <torvalds@osdl.org>:
>
>
> On Tue, 10 Jan 2006, Mark Lord wrote:
> >
> > Are "DEFAULT_*" really the best names to assign to these options?
> > For these options, I'd expect something like "VMUSER_*" or "USERMEM_*".
>
> Good point. I just took the naming from the original one. Especially if
> all the logic is moved into Kconfig files, it has nothing to do with
> DEFAULT what-so-ever. More of a VMSPLIT_3G or similar..

Good. VMSPLIT_ is better than my MEMSPLIT_.

>
>                 Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


--
Coywolf Qi Hunt
