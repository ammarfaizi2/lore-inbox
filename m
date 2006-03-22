Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWCVFh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWCVFh4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 00:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWCVFh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 00:37:56 -0500
Received: from uproxy.gmail.com ([66.249.92.207]:17717 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750777AbWCVFh4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 00:37:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fOLapg0uyBWbmj3xbw6otRAGDKaQn5ITq6Hv+9cxmDrxBxKXo/O52FAxfVgh+oQ55h2RfIX9KZI9Yim7S1k+H7yTMefrlM+3uGOe+GSw5x2YDEXItZtpHdk4T13u9WT+qSonkMjV13G7dBIAZm/l6Hjsa7fCOPc2SHf9MG0O+yM=
Message-ID: <bc56f2f0603212137s727ff0edu@mail.gmail.com>
Date: Wed, 22 Mar 2006 00:37:54 -0500
From: "Stone Wang" <pwstone@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH][5/8] proc: export mlocked pages info through "/proc/meminfo: Wired"
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <442098B6.5000607@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <bc56f2f0603200537i7b2492a6p@mail.gmail.com>
	 <441FEFC7.5030109@yahoo.com.au>
	 <bc56f2f0603210733vc3ce132p@mail.gmail.com>
	 <442098B6.5000607@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The name "Wired" could be changed to which one most kids think better
fits the job.

I choosed "Wired" for:
"Locked" will conflict with PG_locked bit of a pags.
"Pinned" indicates a short-term lock,so not fits the job too.

Shaoping Wang

2006/3/21, Nick Piggin <nickpiggin@yahoo.com.au>:
> Stone Wang wrote:
> > The list potentially could have more wider use.
> >
> > For example, kernel-space locked/pinned pages could be placed on the list too
> > (while mlocked pages are locked/pinned by system calls from user-space).
> >
>
> kernel-space pages are always pinned. And no, you can't put them on the list
> because you never know if their ->lru field is going to be used for something
> else.
>
> Why would you want to ever do something like that though? I don't think you
> should use this name "just in case", unless you have some really good
> potential usage in mind.
>
> ---
> SUSE Labs, Novell Inc.
> Send instant messages to your online friends http://au.messenger.yahoo.com
>
>
