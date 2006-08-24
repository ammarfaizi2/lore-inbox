Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751612AbWHXQsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbWHXQsF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 12:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030382AbWHXQsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 12:48:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:24709 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751620AbWHXQsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 12:48:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=hyCz8zY+3MlDJXaYXlbwFIBEWvkqmyQI3HSMFB1jUETT4gWuHe+EIwtQg56pF61RcEYe1qR8q1ajVXn6c29IIOGGLk/jlYCfrVsIUSBe0s9P60pwLb36SKbmMkG3L38lOoaQ/RP7nhAGkO39hlATpzhUj1ltuAADbO1442Y6xJg=
Date: Thu, 24 Aug 2006 20:47:52 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: David Woodhouse <dwmw2@infradead.org>, David Howells <dhowells@redhat.com>,
       Jens Axboe <axboe@suse.de>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BLOCK: Make it possible to disable the block layer
Message-ID: <20060824164752.GC5205@martell.zuzino.mipt.ru>
References: <32640.1156424442@warthog.cambridge.redhat.com> <20060824152937.GK19810@stusta.de> <1156434274.3012.128.camel@pmac.infradead.org> <20060824155814.GL19810@stusta.de> <1156435216.3012.130.camel@pmac.infradead.org> <20060824160926.GM19810@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824160926.GM19810@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 06:09:26PM +0200, Adrian Bunk wrote:
> On Thu, Aug 24, 2006 at 05:00:16PM +0100, David Woodhouse wrote:
> > On Thu, 2006-08-24 at 17:58 +0200, Adrian Bunk wrote:
> > > There's no reason for getting linux-kernel swamped with
> > > "my kernel doesn't boot" messages by people who accidentally disabled
> > > this option.
> >
> > By that logic, you should make it necessary to set CONFIG_EMBEDDED
> > before you can set CONFIG_EXT3 != Y or CONFIG_IDE != Y too.
>
> That's the difference between Aunt Tillie and a system administrator:
> A system administrator knows which filesystems he wants to use.
>
> > However you dress it up, it's pandering to someone who either lacks the
> > wit, or just can't be bothered, to _look_ at what they're doing when
> > they configure their kernel. And it's a bad thing.
>
> We already have too many user visible options

Examples please.

> and too many ways for people to create non-working kernels.
>
> There's no need for additional traps.

