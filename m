Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278108AbRJ3UvA>; Tue, 30 Oct 2001 15:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278085AbRJ3Uuv>; Tue, 30 Oct 2001 15:50:51 -0500
Received: from vti01.vertis.nl ([145.66.4.26]:46602 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S278136AbRJ3Uuh>;
	Tue, 30 Oct 2001 15:50:37 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rolf Fokkens <fokkensr@linux06.vertis.nl>
To: "David S. Miller" <davem@redhat.com>, rusty@rustcorp.com.au
Subject: Re: iptables and tcpdump
Date: Tue, 30 Oct 2001 21:45:24 -0800
X-Mailer: KMail [version 1.2]
Cc: fokkensr@linux06.vertis.nl, linux-kernel@vger.kernel.org,
        kuznet@ms2.inr.ac.ru
In-Reply-To: <01102817104101.01788@home01> <20011030152812.2e9ba8ee.rusty@rustcorp.com.au> <20011029.213157.39157336.davem@redhat.com>
In-Reply-To: <20011029.213157.39157336.davem@redhat.com>
MIME-Version: 1.0
Message-Id: <01103021452400.03241@home01>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I may have missed something, but I'm not on the maillists which would explain 
why. And the archives dont contain the email messages (yet) between my 
initial question and this part of the discussion.

Apparently my question triggered a discussion about some deep NAT details at 
the skb level. As much as I understand it, something goes wrong with the skb 
cloning in the NAT layer, NAT changes read-only copies.

Is this the cause of the weird data that shows up with tcpdump?

Or in other words: does tcpdump show something buggy?

Rolf

On Tuesday 30 October 2001 09:31, you wrote:
> Hello!
>
> > Alexey, should the NAT layer be doing skb_unshare() before altering the
> > packet?
>
> MUST. Cloned skbs are read-only.
>
> I did not expect such question from you. :-)
>
> Alexey
