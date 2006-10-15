Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWJOKP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWJOKP6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 06:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWJOKP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 06:15:58 -0400
Received: from 1wt.eu ([62.212.114.60]:39940 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1750702AbWJOKP6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 06:15:58 -0400
Date: Sun, 15 Oct 2006 12:12:25 +0200
From: Willy Tarreau <w@1wt.eu>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: 2.4.x: i386/x86_64 bitops clobberings
Message-ID: <20061015101225.GA25397@1wt.eu>
References: <452970AF.8020605@web.de> <20061008224440.GA30172@1wt.eu> <45298184.1050006@web.de> <20061008233617.GA30255@1wt.eu> <4529EBEA.4070602@web.de> <20061014195005.GA2900@1wt.eu> <453205E7.3060003@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453205E7.3060003@web.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2006 at 11:56:55AM +0200, Jan Kiszka wrote:
> Willy Tarreau wrote:
> > ...
> > I have searched the archives for previous occurrences of this recurring
> > problem, and found another alternative which is said to work on all gcc
> > versions. So here's the patch for both x86 and x86_64. I checked that it
> > produces identical code as I obtain with the patch from 2.6. It also
> > fixes your testcase for gcc-2.95 to 4.1.1.
> > 
> > Could you please give it a try ?
> 
> Works fine here as well. Merging it would be welcome.
> 
> Thanks a lot,
> Jan

Thanks for your feedback Jan.
Unless someone quickly raises a problem or points a risk, I will merge it,
and will also put it in next -stable.

Regards,
Willy

