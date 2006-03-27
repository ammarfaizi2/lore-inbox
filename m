Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWC0Phv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWC0Phv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 10:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWC0Phv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 10:37:51 -0500
Received: from xproxy.gmail.com ([66.249.82.193]:23780 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751088AbWC0Phu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 10:37:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W0dMDVbjBe9lNHygZ8h1UYH3fiwZjDKC+Chl87l8qysrMvQ8FBCelPHLL0xghbboYjQhcdh9Do3dgOl/1xjc7hySwXvonwZR67Kfpbq2lvR2/PodgAFpv4iDGtHpiLQjos8pVhNQH9CAyMJm8TTj/6V3UBjpMO16IHhAOyy7ZEs=
Message-ID: <b8bf37780603270737l7c2acb7etdd5c53b3af2eea84@mail.gmail.com>
Date: Mon, 27 Mar 2006 12:37:44 -0300
From: "=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>
To: "Con Kolivas" <kernel@kolivas.org>
Subject: Re: [ck] Re: swap prefetching merge plans
Cc: "Mike Galbraith" <efault@gmx.de>, "Andrew Morton" <akpm@osdl.org>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Jan Engelhardt" <jengelh@linux01.gwdg.de>, ck@vds.kolivas.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200603261934.44552.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20060322205305.0604f49b.akpm@osdl.org>
	 <200603261808.15785.kernel@kolivas.org>
	 <1143358947.9658.19.camel@homer>
	 <200603261934.44552.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/06, Con Kolivas <kernel@kolivas.org> wrote:
> On Sunday 26 March 2006 17:42, Mike Galbraith wrote:
> > On Sun, 2006-03-26 at 19:08 +1100, Con Kolivas wrote:
> > > I guess me criticising your patches made you want to find flaws with my
> > > code.
> >
> > I was simply curious as to how well the damn thing performs Con.  Don't
> > worry though, I'll never make the mistake of testing and reporting ever
> > again.
>
> That was a foolishly bitter comment from me that you did absolutely nothing to
> deserve and I humbly apologise.

@Mike: Do we have a testcase for the sleep problem?

@Con: Is it possible to patch staircase to address this issue as Mike
did with the stock kernel, so I can see the testcase suceeding?
Perhaps changing a little the interactivity detection algorithm
(disabling fairness a little)?

I would like to test any patches to improve this situation on staircase too.
I would like to see more cooperation on both of you, as you are trying
to solve the same problems as I can see.

Please keep walking in the same direction and try to help each other. :)
Thank you both for your effort, it is very apreciated,
--
[]s,

André Goddard
