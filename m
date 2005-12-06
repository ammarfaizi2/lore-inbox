Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932516AbVLFRXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbVLFRXD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 12:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbVLFRXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 12:23:03 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:41321 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932516AbVLFRXC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 12:23:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lkm3S3n7oL0osuEJ/7WJjBo0L2Kw0VKkJhWQcXMqUFy1fbuM9ThOtrE4g1kLVV33Cq5bPmeH+XEQDVunxZzx5LUHsPi6uhQ+6am5ZxMF3b17hnngL8x++tm9EvCLuLYoVgw/KA/yTfYL7h3ugfFmZq3FDiSa8Wh+J6pBChNkazM=
Message-ID: <35fb2e590512060923o37ffa286qb11286f387cabb4f@mail.gmail.com>
Date: Tue, 6 Dec 2005 17:23:01 +0000
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: Linux in a binary world... a doomsday scenario
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051206011844.GO28539@opteron.random>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	 <20051205121851.GC2838@holomorphy.com>
	 <20051206011844.GO28539@opteron.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/05, Andrea Arcangeli <andrea@suse.de> wrote:

> I am convinced that the only way to stop the erosion is to totally stop
> buying hardware that has only binary only drivers (unless you buy it to
> create an open source driver or to reverse engineer the binary only
> driver of course! ;).

That's not enough people to make a big enough difference - but I agree
with the logic and do my part.

One idea for dealing with this is to have the kernel complain more
loudly about binary only drivers - instead of using terms like "taint"
which Sysadmins might casually ignore it might be better to have a
couple of lines of warning message in their syslog explaining what it
means in more graphic terms. Granted that average users won't see this
but it would certainly help to convey the impression that binary only
is "wrong" (it's not putting policy in the kernel, it's embedded
politics in the kernel :P).

> I think messages like the one from Arjan are very positive to let
> people understand the long term effect of binary only drivers

I wrote a couple of articles this month which explain to the average
reader what is wrong with this and how it can be addressed. I used
Greg's mail as an example but will followup with a reference to this
thread - we need to encourage more people to talk about this.

> Perhaps we should add a printk that points to an url on kernel.org
> including Arjan's message every time a non-gpl module gets loaded by the
> kernel. I think it's a matter of educating the customer too or they can
> do mistakes, creating a blacklist would help too.

I like the idea of being far more graphic (no pun intended there) by
describing what this means in everyday language - "using binary only
drivers causes your machine to explode! (may not actually cause
machine to explode)" type stuff.

Jon.
