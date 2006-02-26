Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbWBZRfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWBZRfF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 12:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWBZRfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 12:35:05 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:17466 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751356AbWBZRfD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 12:35:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kLv6U1mr+e6FL2wfdUmpKzPhoQz/9NpRxVtKziqxTfOg6TC/wDiUB8qX3mQXBToCCf5v+mPKi4XB9BlV9Hk5GzTEqIXYmck1vXUNepDk5dpWEP4+HviUWJzVMC4fgnfijhxMwtk65rHQTQsgGBGRRi+9P4YHCFA5ajPvZ/AbKNg=
Message-ID: <9a8748490602260935t2cc15bcdqb500908de55cef5c@mail.gmail.com>
Date: Sun, 26 Feb 2006 18:35:02 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Nick Warne" <nick@linicks.net>
Subject: Re: hda: irq timeout: status=0xd0 DMA question
Cc: "Mark Lord" <lkml@rtr.ca>, linux-kernel@vger.kernel.org
In-Reply-To: <200602261720.34062.nick@linicks.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602261308.47513.nick@linicks.net> <4401E06D.90305@rtr.ca>
	 <9a8748490602260917h31883941qa46dea626276d389@mail.gmail.com>
	 <200602261720.34062.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/06, Nick Warne <nick@linicks.net> wrote:
> On Sunday 26 February 2006 17:17, Jesper Juhl wrote:
>
> > > But perhaps someone may successfully implement this.
> >
> > Unfortunately my machines only have SCSI devices, so I'd have no way
> > to actually test a patch, otherwise I'd be happy to give it a shot - a
> > parameter to disable the behaviour shouldn't be too difficult to
> > implement, and if the default stays as the current behaviour then it
> > shouldn't be too controversial.
> > I wouldn't mind trying to hack up a patch, but it would be untested...
>
> Post it to me - but look at my original post - this is/was on kernel 2.4.32.
> I have yet to see such output on 2.6.x series kernels.
>
> I could test that for you, as I have a test box at work running 2.4.32 that
> gets these strange disk errors sometimes (never have nailed that one down).
>

I haven't been looked at 2.4.x for years, so whatever patch I cook up
would be for 2.6.x

My time currently is limited so it'll probably be a few days before I
have something ready for you to test, but thank you very much for the
offer, I'll get back to you shortly after I've embedded myself in the
IDE code and hopefully cooked something up that makes sense for you to
test.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
