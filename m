Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWCVHmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWCVHmP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 02:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWCVHmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 02:42:15 -0500
Received: from pproxy.gmail.com ([64.233.166.178]:22252 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751079AbWCVHmP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 02:42:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IHsluRHwtfjiqRoJ0sgaxTkl1LSPCPPdtPCKtyWwVtFqF/REpFfC7AdISiYlWQ6mBViGNzV9Dx9lwPJYP35J5LQndrIL9LN0fagNYIGtQvvnFdVWLKan+BgqZ6cw5tOrna4QJSFbzkWd+hXqvSk4o+l15n9XjhPLXQQftlMnAo8=
Message-ID: <489ecd0c0603212342w4124dddfy1bb50c02984c0e8f@mail.gmail.com>
Date: Wed, 22 Mar 2006 15:42:14 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH 1/2]Blackfin archtecture patche for 2.6.16
Cc: "Robin Getz" <rgetz@blackfin.uclinux.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060321223652.25bf07f7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6.1.1.1.0.20060321224917.01ec6970@ptg1.spd.analog.com>
	 <20060321223652.25bf07f7.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/06, Andrew Morton <akpm@osdl.org> wrote:
> Robin Getz <rgetz@blackfin.uclinux.org> wrote:
> >
> > Luke Yang wrote:
> > >On 3/21/06, Andrew Morton <akpm@osdl.org> wrote:
> > > > - How widespread/popular is the blackfin?  Are many devices using it?
> > > >   How old/mature is it?  Is it a new thing or is it near end-of-life?
> > >   As a DSP, Blackfin has been there for years and is somewhat popular.
> > >But as a CPU which can run Linux, we are trying to make it popular.
> > >Anyway a 5$ chip runs Linux and can do audio/video codec is a good toy to
> > >play with.
> >
> > I would not describe it as a toy (sorry Luke),
> >
> > [ interesting info ]
> >
>
> Thanks.
>
> > If you think our patch sucks, fine - let us know where to fix it.
>
> It looks reasonable to me, from a ten-minute-scan.
>
> Well.  All architecture ports suck.  Yours sucks averagely ;)
>
> The todo list of which I'm aware is
>
> - use serial core in that driver
>
> - Fix up that ioctl so it a) doesn't sleep in spinlock and b) compiles
>
> - Use generic IRQ framework
>
> - Review all the volatiles, consolidate them in some helper-in-header-file.
>
> - Sort out maintainance issues, gather signed-off-bys. (Done, it appears)
>
> More things might come out once people start paying more attention, but if
> that's the extent of things, I'd be OK with a merge when you're ready.
  Does this merge has to be within 1 week after the release, so we
have to wait for 2.6.17? Or this can be done on mm-tree?
>


--
Best regards,
Luke Yang
magic.yyang@gmail.com; luke.adi@gmail.com
