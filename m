Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVAGIdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVAGIdd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 03:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVAGIdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 03:33:33 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:62247 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261316AbVAGId3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 03:33:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=WmiPoIhjzSA170nzxsmxDYeDdh4zUmj9EG2T+BZVxEKdROfT7oSFuYOKYZRwX8/yhsSlh9WKJmDaSHBkIHHau0V5GGOAtcqwb1qM1IVDEyVbGx05h9EVCoPeepOicHwIAPLEIgiVdh0UUpQCTyx/P8/EMORiCShF4xso9me1FYs=
Message-ID: <4d8e3fd30501070033f60ab8e@mail.gmail.com>
Date: Fri, 7 Jan 2005 09:33:28 +0100
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: starting with 2.7
Cc: Adrian Bunk <bunk@stusta.de>, "Theodore Ts'o" <tytso@mit.edu>,
       Diego Calleja <diegocg@teleline.es>, Willy Tarreau <willy@w.ods.org>,
       wli@holomorphy.com, aebr@win.tue.nl, solt2@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org
In-Reply-To: <41DDBC52.4020801@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <4d8e3fd30501060603247e955a@mail.gmail.com>
	 <20050106193214.GK3096@stusta.de> <41DDBC52.4020801@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jan 2005 17:31:46 -0500, Bill Davidsen <davidsen@tmr.com> wrote:
> Adrian Bunk wrote:
> > On Thu, Jan 06, 2005 at 03:03:26PM +0100, Paolo Ciarrocchi wrote:
> >
> >>What's wrong in keeping the release management as is now plus
> >>introducing a 2.6.X.Y series of kernels ?
> >>
> >>In short:
> >>http://marc.theaimsgroup.com/?l=linux-kernel&m=109882220123966&w=2
> >
> >
> > Currently (2.6.10), there would have been 11 such branches.
> >
> > If a security vulnerability was found today, this meant backporting and
> > applying the patch to 11 different kernel versions, the oldest one being
> > more than one year old.
> >
> > With more 2.6 versions, there would be even more branches, and the
> > oldest ones becoming more and more different from the current codebase.
> >
> > You could at some point start dropping the oldest branches, but this
> > would mean a migration to a more recent branch for all users of this
> > branch.
> >
> > OTOH, if you migrated relatively late at 2.4.17 to the 2.4 branch, this
> > branch is still actively maintained today, more than 3 years later.
>
> I don't think that's what he meant (I hope not) and I know it's not what
> I had in mind. What I was suggesting is that until 2.6.11 comes out, all
> patches which are fixes (existing feature doesn't work, oops, security
> issues, or other "unusable with the problem triggered" cases) would go
> into 2.6.10.N, where N would be a small number unless we had another 100
> day release cycle.

Yes, that is what I meant.

--
Paolo
Personal home page: www.ciarrocchi.tk
