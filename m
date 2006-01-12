Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932660AbWALSvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932660AbWALSvR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 13:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbWALSvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 13:51:17 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:45280 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932660AbWALSvQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 13:51:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uAs8Z2dEfCXnxtPKBOOjfdfv4GSe37KUCCccfAC6UFgNojhqgXBeWHc6FwblcZ8uebBtZUlISrXNmmG2c7ChP38C/KSg58YsTlIBYEGSqGik6XKsguj/XTR5fotzcDLcW7fXJsu4sYGv6dsvY0nMaKxXXySsvLE7a4fYHc32ZUE=
Message-ID: <9268368b0601121051u1961ed75k7b9be3d79a86e600@mail.gmail.com>
Date: Thu, 12 Jan 2006 14:51:15 -0400
From: Daniel Petrini <d.pensator@gmail.com>
To: Kevin Radloff <radsaq@gmail.com>
Subject: Re: [ck] Re: 2.6.15-ck1
Cc: Con Kolivas <kernel@kolivas.org>, Dave Jones <davej@redhat.com>,
       ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <3b0ffc1f0601051047i24fd1b9mb772cb64dccf6fcb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601041200.03593.kernel@kolivas.org>
	 <20060104190554.GG10592@redhat.com>
	 <20060104195726.GB14782@redhat.com>
	 <200601051010.54156.kernel@kolivas.org>
	 <3b0ffc1f0601051047i24fd1b9mb772cb64dccf6fcb@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/06, Kevin Radloff <radsaq@gmail.com> wrote:
> On 1/4/06, Con Kolivas <kernel@kolivas.org> wrote:
>
> Perhaps fixing the biggest offenders of timer (mis?)use would benefit
> everyone all-around. I haven't really been able to identify who those
> are though, given the lack of sorting in timertop and its
> seemingly-haphazard ordering of data (or is it there and I've missed
> it?).
>

Timertop itself tries to not steals to much cpu whereas tries to be
less intrusive as possible. So ordering is not available yet.
But one can have a backgroud aquisition of data using:

timertop -t 50

There will be 50 s of aquisition saved in a text file so that you can
do some post-processing and order it properly.


Daniel Petrini
--
INdT - Manaus
