Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbUKSU7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbUKSU7r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 15:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbUKSU7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 15:59:47 -0500
Received: from h151_115.u.wavenet.pl ([217.79.151.115]:8655 "EHLO
	alpha.polcom.net") by vger.kernel.org with ESMTP id S261562AbUKSU7n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 15:59:43 -0500
Date: Fri, 19 Nov 2004 21:59:36 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Eric Pouech <pouech-eric@wanadoo.fr>, Roland McGrath <roland@redhat.com>,
       Mike Hearn <mh@codeweavers.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <Pine.LNX.4.58.0411191119320.2222@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.60.0411192151030.23411@alpha.polcom.net>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
 <419E42B3.8070901@wanadoo.fr> <Pine.LNX.4.58.0411191119320.2222@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2004, Linus Torvalds wrote:
> On Fri, 19 Nov 2004, Eric Pouech wrote:
>>
>> the first patch put in BK by Linus doesn't fix the problem. Any plan to fix the
>> two other spots Roland mentionned ?
>
> Can you just try it? I don't have wine, and since my main machine is
> ppc64, and I don't actually have any windows programs to test even on any
> of my laptops...

You could probably use QEMU to run windows binaries on ppc. It has some 
kind of user-mode (per process) emulation and it was designed (at the 
begining) exactly to run wine on !x86. I do not know if the wine emulation 
is still supported (because Fabrice is mainly working on whole-system 
emulation), but you can fix any issues with never wine versions in 5 
minutes I will bet two beers... :-)

And some windows programs to test can be found on the Internet.


Thanks,

Grzegorz Kulewski


PS. Thanks for your work Fabrice!

