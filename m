Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288922AbSA2Hxb>; Tue, 29 Jan 2002 02:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288923AbSA2HxV>; Tue, 29 Jan 2002 02:53:21 -0500
Received: from smtp.cogeco.net ([216.221.81.25]:9702 "EHLO fep2.cogeco.net")
	by vger.kernel.org with ESMTP id <S288922AbSA2HxQ>;
	Tue, 29 Jan 2002 02:53:16 -0500
Subject: Re: A modest proposal -- We need a patch penguin
From: "Nix N. Nix" <nix@go-nix.ca>
To: Stuart Young <sgy@amc.com.au>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Rob Landley <landley@trommello.org>
In-Reply-To: <5.1.0.14.0.20020129173507.01fa2a00@mail.amc.localnet>
In-Reply-To: <200201290446.g0T4kZU31923@snark.thyrsus.com> 
	<5.1.0.14.0.20020129173507.01fa2a00@mail.amc.localnet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99+cvs.2002.01.14.17.03 (Preview Release)
Date: 29 Jan 2002 02:53:14 -0500
Message-Id: <1012290795.13804.6.camel@tux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-29 at 02:10, Stuart Young wrote:
> At 10:00 PM 28/01/02 -0800, Linus Torvalds wrote:
> >I think it helps a lot to have people pick up patches that nobody else
> >wants to maintain, and to gather them up. Andrea does that to some degree.
> >But it is _much_ better if you have somebody who is a point-man for
> >specific areas.
> >
> >The problem with an overall guy is that there can't be too many of them.
> >The very thing you are _complaining_ about is in fact that there are a
> >number of over-all guys without clear focus, which only leads to confusion
> >about who handles what.
> >
> >Clarity is good.
> 
> Perhaps what we need is a patch maintenance system? Now I'm not talking 
> CVS, I'm talking about something that is, in reality, pretty simple. 
> Something that does the following:
> 
>   1. People can submit patches, which are given a unique patch ID.
>   2. Notifications of patches are passed on to (from a selection or 
> automatic detection):
>     a. A module maintainer
>     b. A section maintainer
>     c. A tree maintainer
>     d. Linus Torvalds
>   3. The patches can be reviewed, and immediately:
>     a. Dropped with a canned reject message
>     b. Dropped with a custom reject message
>     c. Dropped but archived for later review
>     d. Suspended/Skipped for later review
>     e. Redelegated up/down to a maintainer
>     f. Accepted, pending testing
>   4. If someone wants to know why their patch is not being accepted:
>     a. They can easily look up the current status
>     b. There is a common reference place
>     c. If their patch is rejected, they can ask for more detail

Kinda like bugzilla, but for patches ? Am I off the deep end here ?


Just a thought.
> 
> Yes it's a tiny patch tracking system. The idea is that if we can make the 
> thing simple to use, simple to understand, and simple to maintain, people 
> will actually use it. Submitting patches by mail in freeform, while 
> reasonably simple, leads to overall complication, and may take longer to 
> sort through.
> 
> It doesn't have to be that involved. A shell script (or perl) could happily 
> do the submission job (which could all still be done by mail, however in a 
> more formatted approach). It'd also be simple to do some sort of web 
> interface if anyone was actually inclined.
> 
> Later, maybe, we can have it track possible conflicts (between waiting 
> patches) and flag them as such so the maintainer is aware of the fact.
> 
> If we can automate some simple, key parts of the kernel maintenance, then 
> this could help immensely, and let everyone get on with the job than the 
> hassle. Maybe we want to re-invent this wheel, maybe we don't.
> 
> PS: Remember this is only a suggestion. I'm not infallible (is anyone?), 
> all I can do is give the big guy ideas (even bad ones), so he can make 
> better decisions. *grin*
> 
> 
> Stuart Young - sgy@amc.com.au
> (aka Cefiar) - cefiar1@optushome.com.au
> 
> [All opinions expressed in the above message are my]
> [own and not necessarily the views of my employer..]
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


