Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262380AbSKKXy4>; Mon, 11 Nov 2002 18:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262409AbSKKXyz>; Mon, 11 Nov 2002 18:54:55 -0500
Received: from webmail.topspin.com ([12.162.17.3]:57950 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id <S262380AbSKKXyy>; Mon, 11 Nov 2002 18:54:54 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [RFC] increase MAX_ADDR_LEN
References: <Pine.LNX.4.44.0211111808240.1236-100000@localhost.localdomain>
	<20021111.151929.31543489.davem@redhat.com>
	<52r8drn0jk.fsf_-_@topspin.com>
	<20021111.153845.69968013.davem@redhat.com>
	<1037060322.2887.76.camel@irongate.swansea.linux.org.uk>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 11 Nov 2002 16:01:43 -0800
In-Reply-To: <1037060322.2887.76.camel@irongate.swansea.linux.org.uk>
Message-ID: <52isz3mza0.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 12 Nov 2002 00:01:39.0968 (UTC) FILETIME=[AD19A800:01C289DE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

    >>>>> On Mon, 2002-11-11 at 23:38, David S. Miller wrote:

    Dave> So how are apps able to specify such larger hw addresses to
    Dave> configure a driver if IFHWADDRLEN is still 6?

    Dave> I'm not going to increase MAX_ADDR_LEN if there is no user
    Dave> ABI capable of configuring such larger addresses properly.

    Alan> The kernel just ignores it. We support multiple devices with
    Alan> larger address lengths. Its mostly a legacy constant

What drivers in the kernel are there with address length more than
MAX_ADDR_LEN?  What do they put dev->addr_len and dev->dev_addr?

Thanks,
  Roland  <roland@topspin.com>
