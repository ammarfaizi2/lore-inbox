Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbWHaFdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWHaFdN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 01:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWHaFdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 01:33:13 -0400
Received: from mail.gmx.de ([213.165.64.20]:55738 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751034AbWHaFdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 01:33:13 -0400
X-Authenticated: #14349625
Subject: Re: A nice CPU resource controller
From: Mike Galbraith <efault@gmx.de>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: balbir@in.ibm.com, Martin Ohlin <martin.ohlin@control.lth.se>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1157007190.6035.14.camel@Homer.simpson.net>
References: <44F5AB45.8030109@control.lth.se>
	 <661de9470608300841o757a8704te4402a7015b230c5@mail.gmail.com>
	 <44F6365A.8010201@bigpond.net.au>
	 <1157007190.6035.14.camel@Homer.simpson.net>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 07:42:20 +0000
Message-Id: <1157010140.18561.23.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-31 at 06:53 +0000, Mike Galbraith wrote:
> On Thu, 2006-08-31 at 11:07 +1000, Peter Williams wrote:
> 
> > But your implication here is valid.  It is better to fiddle with the 
> > dynamic priorities than with nice as this leaves nice for its primary 
> > purpose of enabling the sysadmin to effect the allocation of CPU 
> > resources based on external considerations.
> 
> I don't understand.  It _is_ the administrator fiddling with nice based
> on external considerations.  It just steadies the administrator's hand.

When extended to groups, I see your point.  The admin would lose his
ability to apportion bandwidth _within_ the group because he's already
turned his only knob.  That is going to be just as much of a problem for
other methods though, and is just a question of how much complexity you
want to pay to achieve fine grained control.

	-Mike

