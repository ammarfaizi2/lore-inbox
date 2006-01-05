Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbWAEN1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbWAEN1Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 08:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWAEN1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 08:27:25 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:18264 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751001AbWAEN1Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 08:27:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Iwqd/ItH9Zfe2tTWJlH5nogIpG0rJb3pbUqF1T7NkT+k7XU4oV0TA2vp8f0uF1dU4+euKljuJtv+8wxiHjCnaqSD7xH9QAltwX/PDP4S4LpwKoIX+xLit593z4a9aiL9ceMk7ZHCUG5KzEye/uo0ilR97WP4ZLBZ0bs4jHKX0ZM=
Message-ID: <9a8748490601050527x407ff85dref45774d5eb131d9@mail.gmail.com>
Date: Thu, 5 Jan 2006 14:27:23 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: 80 column line limit?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060105130249.GB29894@vrfy.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060105130249.GB29894@vrfy.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/06, Kay Sievers <kay.sievers@vrfy.org> wrote:
> Can't we relax the 80 column line rule to something more comfortable?

Please don't.

I very often work in console (or xterm) and editing kernel code. Files
with lines >80 col. are quite annoying to have to scroll left/right in
and not being able to see the end of lines.
Also, very long lines are annoying to read even if they do fit on your
screen, I can easily fit code lines of 200 chars or more in a GUI
editor in X but IMO readability suffers compared to when that long
line is broken up into a few shorter pieces - less horizontal eye
movement.

> These days descriptive variable/function names are much more valuable,
> I think.
>
Short names can be descriptive too, and long names are not nice to
have to type all the time. Besides, if you need a long description of
a variable or function then use a comment don't try and encode
everything into the name.


> Just by looking at random examples in the tree, seems the 80 column
> rule does more harm than good. I always find myself start shortening
> names just to fit the line limit and not to need to line-wrap a statement.

Sure, if you name variables like  "int temporary_place_holder" instead
of simply "int tmp" and similar, then 80cols are annoying, but I'd say
the problem there is not the line length limit but the name being
used.
Short and sweet is my preference.


> We even use #defines sometimes to access simple structure members and
> the like, only to fit that rule.
>
> So, are we sure that 80 columns is still valuable, looking at the
> side-effects of artificially shortended variable/function names and
> line-wrapped statements, caused by this rule?
>
IMHO it's a good rule and we should stick to it.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
