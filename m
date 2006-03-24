Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWCXFEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWCXFEc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 00:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWCXFEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 00:04:31 -0500
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:45792 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932096AbWCXFEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 00:04:31 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [interbench numbers] Re: interactive task starvation
Date: Fri, 24 Mar 2006 16:04:06 +1100
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>, Willy Tarreau <willy@w.ods.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com, Peter Williams <pwil3058@bigpond.net.au>
References: <1142592375.7895.43.camel@homer> <200603241121.02868.kernel@kolivas.org> <1143176550.7713.23.camel@homer>
In-Reply-To: <1143176550.7713.23.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603241604.07321.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 March 2006 16:02, Mike Galbraith wrote:
> I've separated the buglet fix parts from the rest, so there are four
> patches instead of two.  I've also hidden the knobs, though for the
> testing phase at least, I personally think it would be better to leave
> the knobs there for people to twiddle.  Something Willy said indicated
> to me that 'credit' would be more palatable than 'grace', so I've
> renamed and updated comments to match.  I think it might look better,
> but can't know since 'grace' was perfectly fine for my taste buds ;-)
>
> I'll post as soon as I do some more cleanup pondering and verification.

Great. I suggest making the base patch have the values hard coded as #defines 
and then have a patch on top that turns those into userspace tunables we can 
hand tune while in -mm which can then be dropped if/when merged upstream.

Cheers,
Con
