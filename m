Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751756AbWCFPsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbWCFPsM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 10:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbWCFPsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 10:48:12 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:23191 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751756AbWCFPsL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 10:48:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KC/+gd3Wwk5bnxz7Z/X48uYvMl82dlu+ADKskyLQzqIC2cbFUA33h24g+6GwcCZAN9FKtULCW9uLNRBkkNOLSksHx9VZ3ie09Kf0GMddxs1T8swhZVG1owFR2qrI9JIxeOJsiZ6GPFKUNKBuyU42M/4r8LXoYCYO8AKI+R1Zg8k=
Message-ID: <9a8748490603060748x6fbe715eq4c4a55a040cc6238@mail.gmail.com>
Date: Mon, 6 Mar 2006 16:48:10 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Giacomo A. Catenazzi" <cate@debian.org>
Subject: Re: [kbuild-devel] Re: kbuild: Problem with latest GNU make rc
Cc: "Sam Ravnborg" <sam@ravnborg.org>, "Paul D. Smith" <psmith@gnu.org>,
       bug-make@gnu.org, LKML <linux-kernel@vger.kernel.org>,
       kbuild-devel@lists.sourceforge.net, "Art Haas" <ahaas@airmail.net>
In-Reply-To: <440C4472.8000509@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <17413.49617.923704.35763@lemming.engeast.baynetworks.com>
	 <20060304214026.GB1539@mars.ravnborg.org>
	 <17419.25684.389269.70457@lemming.engeast.baynetworks.com>
	 <20060305231954.GA25710@mars.ravnborg.org>
	 <440C4472.8000509@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/06, Giacomo A. Catenazzi <cate@debian.org> wrote:
> Sam Ravnborg wrote:
> >>   sr> Suggestion:
> >>   sr> We are now warned about an incompatibility in kbuild and we will
> >>   sr> fix this asap. But that you postpone this particular behaviour
> >>   sr> change until next make release. Maybe you add in this change as
> >>   sr> the first thing after the stable relase so all bleeding edge make
> >>   sr> users see it and can report issues.
> >>
> >> I am willing to postpone this change.  However, I can't say how much of
> >> a window this delay will give you: I can say that it's extremely
> >> unlikely that it will be another 3 years before GNU make 3.82 comes out.
> >
> > One year would be good. The fixed kernel build will be available in an
> > official kernel in maybe two or three months form now. With current pace
> > we will have maybe 3 more kernel relase until this hits us. And only on
> > bleeding edge machines.
>
> I don't think is a big issue. The short-cut "compile only the necessary
> files" is used mainly by developers.
> Anyway the kernel will remain correct. Maybe for old kernel it take more
> time to build the kernel, but correct.
>
> BTW Debian building tools (IIRC) clean the sources before every kernel
> building process, and in 2.4 (and previous) it was high recommended to
> clean and recompile all kernel before any changes, so no big issue in
> these cases.
> I don't know other "normal use", but I think it is not a big issue if
> people will need a complete build in the rare (IMHO) case that they
> want to recompile kernel (with small patches or changes in configuration).
>

Rebuilding the kernel tens (or hundreds) of times may be rare for most
ordinary users, but it's quite common for kernel developers.
Rebuilding the entire kernel every time you make a small change is a
big problem and cost a lot of people a lot of time - and the people
who will bear the cost are the ones who have to build many kernels.
IMHO this is a big problem.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
