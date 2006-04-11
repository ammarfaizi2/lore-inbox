Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbWDKSL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbWDKSL5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 14:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWDKSL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 14:11:57 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:51717 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750839AbWDKSL4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 14:11:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rdMOsjWW5d8o0R0OuFPlBrclYQoJl5sPrWxQhKzZ/LB0V671Ygd+FjTLdHvjBVuzqQvC9lrwMQ1BsL4G+Pm4JWZgLIUK9coXGlv/wMQge1ASLRqcfCGhunQI7KsRm+bk/J5iaM4TFPdQwxgUdWGCbZnuVEoFJj/AY6K5yjFx4J8=
Message-ID: <5a4c581d0604111111s4946b39x3686ade1275ded90@mail.gmail.com>
Date: Tue, 11 Apr 2006 20:11:55 +0200
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Andreas Mohr" <andi@rhlx01.fht-esslingen.de>
Subject: Re: 40% IDE performance regression going from FC3 to FC5 with same kernel
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060411122806.GA26836@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a4c581d0604080747w61464d48k5480391d98b2bc47@mail.gmail.com>
	 <20060411122806.GA26836@rhlx01.fht-esslingen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/06, Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:
> Hi,
>
> On Sat, Apr 08, 2006 at 04:47:18PM +0200, Alessandro Suardi wrote:
> > I'll be filing a FC5 performance bug for this but would like an opinion
> >  from the IDE kernel people just in case this has already been seen...
> >
> > I just upgraded my home K7-800, 512MB RAM box from FC3 to FC5
> >  and noticed a disk performance slowdown while copying files around.
>
> Just another suggestion: try eliminating/pinpointing I/O scheduler issues
> (switch e.g. to "noop" at /sys/block/hda/queue/scheduler and compare again)

Thanks Andi. Tried every scheduler (my default is anticipatory) and
 there aren't meaningful differences - 18.3 to 18.6MB/s.

As a further data point, my box can burn a 8x DVD+R at up to 7.1x
 average speed under FC3, while it barely keeps up with 4x in FC5.

--alessandro

 "Dreamer ? Each one of us is a dreamer. We just push it down deep because
   we are repeatedly told that we are not allowed to dream in real life"
     (Reinhold Ziegler)
