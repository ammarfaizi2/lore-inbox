Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965290AbWADWaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965290AbWADWaz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965292AbWADWay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:30:54 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:1169 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965290AbWADWax convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:30:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bv7snVxi6GArJG9z1qM/Lezgqu3M4eTb8f81Ss24mMX0vb5F6jalYAHLYIOajXJMyPG86R4hOMkQZcLJwrVKHcoWoRDF8Hk5mTIFDEefSgv4qUF3tEfAvEv9vsUorhx+djPjZQv8qm3V0vAN69u4KaFTBCCW7zxuIQWV7cHuPqc=
Message-ID: <9a8748490601041430g67720b14h10474d9be5059d9@mail.gmail.com>
Date: Wed, 4 Jan 2006 23:30:52 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Nick Warne <nick@linicks.net>
Subject: Re: 2.6.14.5 to 2.6.15 patch
Cc: Greg KH <greg@kroah.com>, Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       webmaster@kernel.org
In-Reply-To: <200601042220.59637.nick@linicks.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601041710.37648.nick@linicks.net>
	 <200601042210.47152.nick@linicks.net>
	 <20060104221549.GA13254@kroah.com>
	 <200601042220.59637.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/06, Nick Warne <nick@linicks.net> wrote:
> On Wednesday 04 January 2006 22:15, Greg KH wrote:
>
> > > Then when 2.6.15 came out, that was it!  No patch for the 'latest stable
> > > kernel release 2.6.14.5'.  It was GONE!
> >
> > That's because 2.6.15 is the latest stable release.
> >
> > > OK, I suppose we are all capable of getting back to where we are on
> > > rebuilding to latest 'stable', but there _is_ a missing link for somebody
> > > that doesn't know - and I think backtracking patches isn't really the way
> > > to go if the 'latest stable release' isn't catered for.
> >
> > Um, it is, see my sentance above.  And if you want to download older
> > stable releases, you can jump to the proper directory, how long do you
> > want us to put older stable releases on the main page for?  :)
>
> OK, I see what you mean, but 2.6.14 wasn't the latest 'release' - 2.6.14.5 was

2.6.14 was indeed the latest mainline/Linus release, all the 2.6.14.x
kernels were -stable kernels released by the -stable team, and when
2.6.15 shows up noone knows how many further -stable kernels the team
will release for 2.6.14 (most likely 1 at most, but it's not set in
stone).

> (according to kernel.org).  Yet there is no upgrade path for that build (or
> any other .x releases)
>
> It is a bit of a mess really.
>
but, a 2.6.14.6 kernel might come out *after* 2.6.15, then what?

There's a 2.6.15 patch on the kernel.org frontpage that's a 2.6.14 ->
2.6.15 delta, if people are using 2.6.14.x then I think it's fair to
assume they have that .x patch around somewhere (or know where to find
it) and can easily revert it to then apply the 2.6.15 patch.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
