Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWBBVpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWBBVpy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 16:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWBBVpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 16:45:54 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:32799 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932302AbWBBVpx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 16:45:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IcRw9WqbdjVzQLErMyvEgm9jD1eoFzq7ZjCnSh5ikRoqID4kkQTv2g0r5rGI7Bv9t8CCl66GTvpC6obvKbQ7785AhANu8jeovf2M0sk2C9qCrmHmSO+ojeT38XbSGWkL84sWaQ0PchbdGIEkUXI6ocLt9exnt9/BUYv11NUUC5M=
Message-ID: <d120d5000602021345i255bb69eydb67bc1b0a448f8d@mail.gmail.com>
Date: Thu, 2 Feb 2006 16:45:52 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Wanted: hotfixes for -mm kernels
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1138913633.15691.109.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602021502_MC3-1-B772-547@compuserve.com>
	 <1138913633.15691.109.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/06, Lee Revell <rlrevell@joe-job.com> wrote:
> On Thu, 2006-02-02 at 15:00 -0500, Chuck Ebbert wrote:
> > Most -mm kernels have small but critical bugs that are found shortly
> > after release.  Patches for these are posted on linux-kernel but
> > they aren't made available on kernel.org until the next -mm release.
> >
> > Would it be possible to create a hotfix/ directory for each -mm
> > release and put those patches there?  A README could explain that
> > the fixes are untested.  At least people reading the files could
> > see an issue exists even if they're not brave enough to try the
> > patch. :)
>
> I doubt it - mm is an experimental kernel, hotfixes only make sense for
> production stuff.  It moves too fast.
>
> A better question is what does -mm give you that mainline does not, that
> causes you to want to "stabilize" a specific -mm version?
>

Some people just run -mm so the hotfixes/* would help them to get
their boxes running until the next -mm without having to hunt through
LKML for bugs already reported/fixed. This will allow better testing
coverage because most obvious bugs are caught almost immediately and
then people can continue using -mm to find more stuff.

--
Dmitry
