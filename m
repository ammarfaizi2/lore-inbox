Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbWBZRRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbWBZRRO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 12:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWBZRRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 12:17:14 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:30413 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750917AbWBZRRN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 12:17:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LS4FnWknVmIFGtG3Me2eDvRx2FEbL/bWzZhdYGzE66VUJkX0HePu/iu+ViN324Lng++1FjHO5QLwFWbr0Lflc3ZitcSN+gEPHGSFrUHcMQxfEu6tOvf/AN17Z8jpFQXzNZxu95MVKmT2VwAzRQVpP7rpqkTIGMa/aI5UBkoSGAg=
Message-ID: <9a8748490602260917h31883941qa46dea626276d389@mail.gmail.com>
Date: Sun, 26 Feb 2006 18:17:12 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Mark Lord" <lkml@rtr.ca>
Subject: Re: hda: irq timeout: status=0xd0 DMA question
Cc: "Nick Warne" <nick@linicks.net>, linux-kernel@vger.kernel.org
In-Reply-To: <4401E06D.90305@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602261308.47513.nick@linicks.net> <4401B689.5050106@rtr.ca>
	 <9a8748490602260615i8b72ae4ta3c6b13b568ca45d@mail.gmail.com>
	 <4401E06D.90305@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/06, Mark Lord <lkml@rtr.ca> wrote:
> Jesper Juhl wrote:
>  >
> > Or how about an option for the IDE driver to "not do that" that people
> > could enable if needed/wanted?
> > Or just change the code to "not do that" since we are no longer in the
> > mid-1990s?
>
> Well, yes.  That's what I would do, were I still maintaining the IDE layer.
>
> But that code has become so twisted and confused since then,
> that a change like this is probably too risky/challenging for
> the current maintainers.  It seems really easy to break stuff
> when touching parts of that code now, and people don't like it
> much when their hard drives get corrupted.
>
> But perhaps someone may successfully implement this.
>
Unfortunately my machines only have SCSI devices, so I'd have no way
to actually test a patch, otherwise I'd be happy to give it a shot - a
parameter to disable the behaviour shouldn't be too difficult to
implement, and if the default stays as the current behaviour then it
shouldn't be too controversial.
I wouldn't mind trying to hack up a patch, but it would be untested...

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
