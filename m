Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbVDEMDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbVDEMDY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 08:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVDEMDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 08:03:24 -0400
Received: from hades.almg.gov.br ([200.198.60.36]:38083 "EHLO
	hades.almg.gov.br") by vger.kernel.org with ESMTP id S261704AbVDEMDI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 08:03:08 -0400
Message-ID: <42527E89.4040506@almg.gov.br>
Date: Tue, 05 Apr 2005 09:03:21 -0300
From: Humberto Massa <humberto.massa@almg.gov.br>
User-Agent: Mozilla Thunderbird 1.0+ (Windows/20050224)
MIME-Version: 1.0
To: debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear
 copyright notice.
References: <h-GOHD.A.KL.s2aUCB@murphy>
In-Reply-To: <h-GOHD.A.KL.s2aUCB@murphy>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:

>  You know, the fact that Red Hat, SuSE, Ubuntu, and pretty much all
>  other commercial distributions have not been worried about getting
>  sued for this alleged GPL'ed violation makes it a lot harder for me
>  (and others, I'm sure) take Debian's concerns seriously.

I said in other e-mail, and I will repeat: it's not their (Debian's) 
fault. Their responsibility is greater. Why? Because when RedHat puts 
something it shouldn't in their distro it's *their* assets that will 
answer for some copyright violation damages. In Debian's case, it's the 
assets of: some DDs, the mirror network, derived-distro distributors, CD 
vendors, etc... This is just a case of Debian being "fiscally 
responsible", i.e., not treating other people's money as trash.

>  The problem may be that because Debian is purely a non-profit, and so
>  it can't clearly balance the costs and benefits of trying trying to
>  avoid every single possible risks where someone might decide to file
>  a lawsuit.  Anytime you do *anything* you risk the possibility of a
>  lawsuit, and if you allow the laywers to take over your business
>  decisions, the natural avoid-risks-all-costs bias of lawyers are such
>  that it will either drive a company out of business, or drive a
>  non-profit distribution into irrelevance.....
>
>  If Debian wants to be this fanatical, then let those Debian
>  developers who care do all of the work to make this happen, and stop
>  bothering LKML.  And if it continues to remain the case that a user
>  will have to manually edit /etc/apt/sources.lists (using vi!) to
>  include a reference to non-free in order to install Debian on a
>  system that requires the tg3 device driver, then I will have to tell
>  users who ask me that they would be better off using some other
>  distribution which actually cares about their needs.
>
>  - Ted

In this I agree with you, and Greg KH was singing approximately the same 
tune, if I understood correctly: this is a matter to be resolved by 
distributors and, if someone solves this in a practical and good way, it 
will eventually end in the pristine-blessed-Linus-kernel-tree, to the 
benefit of others.

But, the question made here was a subtler one and you are all biting 
around the bush: there *are* some misrepresentations of licenses to the 
firmware blobs in the kernel (-- ok, *if* you consider that hex dumps 
are not source code). What Sven asked was: "Hey, can I state explicitly 
the distribution state in the source files, by means of adding some 
comments?".

Maybe he should contact each file's maintainer individually, but it 
seems (IMHO) that he thought "hey, they all hang around lkml anyway"...

I think even a clarification "this firmware hexdump is considered to be 
the source code, and it's GPL'd" would do, but I must put my asbestos 
suit everytime I say it. :-)

HTH,

Massa


