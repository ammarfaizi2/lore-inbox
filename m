Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWCFAFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWCFAFo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 19:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWCFAFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 19:05:44 -0500
Received: from pproxy.gmail.com ([64.233.166.178]:28483 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750761AbWCFAFn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 19:05:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HyLWinepd5ubwO31tDD9/j3U3OlcablNgOYegeCisMz8GIyznNExiQFx0VGMOtCuayEW6AY3OrZZZFBKi+c5/BJSNAbPJMdhI58K9g4yKvnQAKalUMa4kT5DjKdPyd5uukHMYN/TB0jZhD5Ah9kwjQ0iTcICtna2sULpGrbFoaM=
Message-ID: <9a8748490603051605w7a62024nf5f630451ceac443@mail.gmail.com>
Date: Mon, 6 Mar 2006 01:05:42 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: 2.6.16-rc5-mm1
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Laurent Riffard" <laurent.riffard@free.fr>,
       linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
       "Martin Bligh" <mbligh@mbligh.org>,
       "Christoph Lameter" <clameter@engr.sgi.com>
In-Reply-To: <m1veuwiihi.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060228042439.43e6ef41.akpm@osdl.org>
	 <9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>
	 <4404CE39.6000109@liberouter.org>
	 <9a8748490602281430x736eddf9l98e0de201b14940a@mail.gmail.com>
	 <4404DA29.7070902@free.fr> <20060228162157.0ed55ce6.akpm@osdl.org>
	 <9a8748490603011741o122e652ica20a9fcffed3d41@mail.gmail.com>
	 <9a8748490603021216u344a3915g6ca0df42bb51b867@mail.gmail.com>
	 <m1veuwiihi.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> "Jesper Juhl" <jesper.juhl@gmail.com> writes:
>
> > On 3/2/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> >> On 3/1/06, Andrew Morton <akpm@osdl.org> wrote:
> >> >
> >> > Could people please test a couple more patchsets, see if we can isolate it?
> >> >
> >> > http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.16-rc5-mm1.1.gz
> >> >
> >>
> >> Haven't had time to test this one yet, and won't have time until tomorrow :(
> >>
> >
> > I just tested this kernel and it builds and runs just fine. Can't
> > crash it with my eclipse test case.
> >
> >>
> >> > and http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.16-rc5-mm1.2.gz is
> >>
> >> I've tested this one and I can't crash it with eclipse like I could
> >> plain old 2.6.16-rc5-mm1
> >>
> >
> > With all the recent patches and proposed patches and discussions about
> > various approaches to fix this I've lost track.
> >
> > What kernel with what patches applied and/or reverted would it make
> > the most sense for me to test now, in order to provide the most useful
> > testing?
>
> So it looks like we have this tracked and fixed.  Andrew included my
> fix in:
> http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.16-rc5-mm2-pre1.gz
>
> So just confirming that the fixed actually worked would probably be
> the biggest help.
>
> The problem should be fixed unless there is something else that
> triggers the horrible and mysterious kernel death.  So you are
> getting the same results as everyone else.
>

2.6.16-rc5-mm2 works fine for me. Can't crash it with eclipse.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
