Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030266AbVLFVzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbVLFVzP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 16:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbVLFVzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 16:55:14 -0500
Received: from xproxy.gmail.com ([66.249.82.197]:27243 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030267AbVLFVzN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 16:55:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OtTOi3FOj9sf9Rtora/4jNhX6agOh49oplRGcc/NbRH62R8U59Wl+lI5Ue7FCH4+LMSxT0mAuugIzOaIGnqhw68bAE8La0zdre0tfYiNQ0uNKuI0OO2OprtMODAgojEjFep7nQljx4fiAKCLg8ybVQmVuWMZeKG6LFqy3/AvULI=
Message-ID: <21d7e9970512061355o598dbbfkcd4bfb7140efb69c@mail.gmail.com>
Date: Wed, 7 Dec 2005 08:55:12 +1100
From: Dave Airlie <airlied@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux in a binary world... a doomsday scenario
Cc: Lee Revell <rlrevell@joe-job.com>, Jeff Garzik <jgarzik@pobox.com>,
       Brian Gerst <bgerst@didntduck.org>,
       Arjan van de Ven <arjan@infradead.org>, "M." <vo.sinh@gmail.com>,
       Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1133900736.23610.76.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	 <20051206030828.GA823@opteron.random>
	 <f0cc38560512060307m2ccc6db8xd9180c2a1a926c5c@mail.gmail.com>
	 <1133869465.4836.11.camel@laptopd505.fenrus.org>
	 <4394ECA7.80808@didntduck.org> <4395E2F4.7000308@pobox.com>
	 <1133897867.29084.14.camel@mindpipe> <4395E962.2060309@pobox.com>
	 <1133898911.29084.25.camel@mindpipe>
	 <1133900736.23610.76.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> The risk is that by reading the disassembled binary and rewriting it a
> programming might actually be deemed to have copied code if they
> accidentally just reproduce the original implementation.
>
>
> Often of course disassembly is the hard way to solve the problem. Firing
> up the driver with analyser tools and studying how it works can be far
> more informative. With the ATI R3xx work asking the binary driver to
> draw a wide range of triangles and monitoring the command queue output
> for each request  provides very good info, while attempting to deciphers
> megabytes of windows 3D driver code, which is likely to contain self
> modifying or JIT generated pipelines, is going to be extremely hard
> work.
>

I can pretty much guarantee nobody is stupid enough to even think
about attaching a debugger or disassembler to fglrx, doing black-box
reverse engineering is sufficent for everything, and as the r300 is
derived in many respects from the r200, we have a lot of info from
it..

Dave.
