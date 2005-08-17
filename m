Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbVHQPTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbVHQPTp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 11:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbVHQPTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 11:19:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34950 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751146AbVHQPTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 11:19:44 -0400
Date: Wed, 17 Aug 2005 08:19:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Airlie <airlied@gmail.com>
cc: Helge Hafting <helge.hafting@aitel.hist.no>,
       Helge Hafting <helgehaf@aitel.hist.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: rc6 keeps hanging and blanking displays
In-Reply-To: <21d7e997050817040523a1bf46@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0508170815370.3553@g5.osdl.org>
References: <42F89F79.1060103@aitel.hist.no>  <Pine.LNX.4.58.0508150843380.3553@g5.osdl.org>
  <20050815221109.GA21279@aitel.hist.no>  <21d7e99705081516182e97b8a1@mail.gmail.com>
  <21d7e99705081516241197164a@mail.gmail.com>  <20050816165242.GA10024@aitel.hist.no>
  <Pine.LNX.4.58.0508160955270.3553@g5.osdl.org>  <20050816211424.GA14367@aitel.hist.no>
  <21d7e99705081616504d28cca5@mail.gmail.com>  <43031A12.8020301@aitel.hist.no>
 <21d7e997050817040523a1bf46@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Aug 2005, Dave Airlie wrote:
>
> > git is completely new to me - is there a git-specific way to get this
> > patch, or should I download it the usual way from somewhere?
> 
> Just grab it from the link to comment #16 on 
> http://bugzilla.kernel.org/show_bug.cgi?id=4965

That's a good one to try (and if it matters, can you please do a full 
"lspci -vvx" for before-and-after? In fact, it would probably be good to 
do that _regardless_ - do it with an old known-good kernel, and with one 
recent kernel).

At the same time, something struck me. Does it happen to be much warmer in 
your room lately? As in due to a heatwave? I'm just wondering if it might 
be something as silly as a thermal shutdown.

			Linus
