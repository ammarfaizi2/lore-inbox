Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269643AbRHQEdW>; Fri, 17 Aug 2001 00:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269645AbRHQEdM>; Fri, 17 Aug 2001 00:33:12 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:34941 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S269643AbRHQEcw>; Fri, 17 Aug 2001 00:32:52 -0400
Date: Fri, 17 Aug 2001 00:29:58 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: "David S. Miller" <davem@redhat.com>
cc: <zippel@linux-m68k.org>, <aia21@cam.ac.uk>, <tpepper@vato.org>,
        <f5ibh@db0bm.ampr.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.9 does not compile [PATCH]
In-Reply-To: <20010816.195906.38712979.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0108170027070.28617-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Aug 2001, David S. Miller wrote:

> Wrong.  This is legal:
>
> int test(unsigned long a, int b)
> {
> 	return min(a, b);
> }
>
> And the compiler will warn about it with your typeof version.
> That is dumb and unacceptable.

I would hope that it would warn: what if a is the maximum size that an
array can be and b is a value passed in from userland?  Most definately
not an expected result.

		-ben

