Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030275AbWHDB3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbWHDB3H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 21:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbWHDB3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 21:29:07 -0400
Received: from smtp-out.google.com ([216.239.45.12]:8427 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030275AbWHDB3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 21:29:05 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=HiUl2Xh5Su8bXTNC1nWQaudzIIG2ZSAZW9Dj8OrQ6dOB060XVZ9iG2pEgdWUXKLzH
	C66jIdKePTL71U680V9Hw==
Message-ID: <44D2A2C1.6030300@google.com>
Date: Thu, 03 Aug 2006 18:28:33 -0700
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Nate Diller <nate.diller@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] [2/2] Add the Elevator I/O scheduler
References: <5c49b0ed0608031603v5ff6208bo63847513bee1b038@mail.gmail.com> <20060803235304.GB7265@redhat.com>
In-Reply-To: <20060803235304.GB7265@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
>  > +/****************
>  > + *
>  > + * Advantages of the Textbook Elevator Algorithms
>  > + *  by Hans Reiser
>  > + *
>  > + * In people elevators, they ensure that the elevator never changes
>  > + * direction before it reaches the last floor in a given direction to which
>  > + * there is a request to go to it.  A difference with people elevators is
>  > + * that disk drives have a preferred direction due to disk spin direction
>  > + * being fixed, and large seeks are relatively cheap, and so we (and every
>  > + * textbook) have a one way elevator in which we go back to the beginning 
>  > > blah blah blah..
> 
> This huge writeup would probably belong more in Documentation/

Hi Dave,

Surely you did not mean to characterize his documentation as blather?  It seems
to be of very good quality, we need to encourage that level of diligence.  As
far as moving it to Documentation goes, my immediate reaction is I sure do like
it when the coder cares enough about my understanding of what he's doing to
put such effort into trying to make sure I understand what he's doing and why
he's doing it.  Having it right in the code removes a level of indirection when
reading that might make the difference between me reading and not reading the
documentation, which in turn might make the difference between understanding and
not understanding the code.  Agreed it's a bit much at least all in one piece.

Maybe precis the in-line documenation and move the greater literary effort to
Documentation, with the requisite "see Documentation/" line?

Regards,

Daniel
