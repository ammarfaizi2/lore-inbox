Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbVHNX2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbVHNX2y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 19:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbVHNX2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 19:28:54 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:7656 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932349AbVHNX2y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 19:28:54 -0400
Subject: Re: [Patch] Support UTF-8 scripts
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Stephen Pollei <stephen.pollei@gmail.com>,
       Jason L Tibbitts III <tibbs@math.uh.edu>,
       "Martin v." =?ISO-8859-1?Q?L=F6wis?= <martin@v.loewis.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1124049592.4918.2.camel@mindpipe>
References: <42FDE286.40707@v.loewis.de>
	 <feed8cdd0508130935622387db@mail.gmail.com>
	 <1123958572.11295.7.camel@mindpipe> <ufazmrl9h3u.fsf@epithumia.math.uh.edu>
	 <feed8cdd050814125845fe4e2e@mail.gmail.com>
	 <1124049592.4918.2.camel@mindpipe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Mon, 15 Aug 2005 00:55:54 +0100
Message-Id: <1124063754.28862.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-08-14 at 15:59 -0400, Lee Revell wrote:
> I know the alternatives are available.  That doesn't make it any less
> idiotic to use non ASCII characters as operators.  I think it's a very
> slippery slope.  We write code in ASCII, dammit.

Its a trivial patch and there is a lot to be said for UTF-8 scripts. As
to writing code in ascii, the kernel regularly has outbreaks of either
UTF-8 or ISO-8859-* especially in the docs directory. Standardising
these on UTF-8 would be helpful.

Yes the kernel code is C so ASCII except for the odd abuser of the ©
symbol.

Alan

