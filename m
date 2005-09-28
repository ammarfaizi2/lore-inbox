Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbVI1I4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbVI1I4J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 04:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbVI1I4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 04:56:09 -0400
Received: from qproxy.gmail.com ([72.14.204.196]:34987 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030223AbVI1I4I convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 04:56:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ns2COHYcFgZj1QYDhAchTlliB0aK5UVEwmBqbzEI9c8e8rN224ITLEdnkMhOXkx8JoFhHTGF5sr3a5oWR4R8Xrr1Dzt6FP1pYDMCtJGAs++dv+4J4SqXDPyrtZPdRT6XQbaiBDBOqfOxitRsegfWMjLN8jHBwlpqrXnFem5AbgE=
Message-ID: <98b62faa050928015677d7253b@mail.gmail.com>
Date: Wed, 28 Sep 2005 01:56:05 -0700
From: <iodophlymiaelo@gmail.com>
Reply-To: iodophlymiaelo@gmail.com
To: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Subject: Re: raw aio write guarantee
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200509280757.j8S7vmjB023730@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <98b62faa050928001275d28771@mail.gmail.com>
	 <200509280757.j8S7vmjB023730@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/05, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> On Wed, 28 Sep 2005 00:12:33 PDT, iodophlymiaelo@gmail.com said:
>
> > Just a quick question: How can a user-mode application ensure that an
> > AIO write on a raw block device (i.e. open()ed with O_DIRECT) has
> > really -really- been written to the disk and not residing in an on-disk
> > write cache where it could be lost in case of a power failure?
>
> Step 1: Make sure you buy disk drives that don't lie through their teeth
> regarding details such as "is the write cache enabled?" or "did the flush
> cache work?".  Such hardware can generate vast amounts of bad karma....
>
> Step 2: Buy a UPS.  A good one.  You can't lose the cache during a power failure
> that doesn't actually hit.
>
> Step 3: http://catb.org/~esr/jargon/html/M/molly-guard.html - You want these.
> Lots of them.
>

I was asking what a user-application can do to prevent data loss, not
an application-user.
