Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129847AbRBSQOo>; Mon, 19 Feb 2001 11:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129947AbRBSQOf>; Mon, 19 Feb 2001 11:14:35 -0500
Received: from [193.120.224.170] ([193.120.224.170]:55428 "EHLO
	florence.itg.ie") by vger.kernel.org with ESMTP id <S129847AbRBSQOX>;
	Mon, 19 Feb 2001 11:14:23 -0500
Date: Mon, 19 Feb 2001 16:13:44 +0000 (GMT)
From: Paul Jakma <paulj@itg.ie>
To: Ansari <mike@khi.sdnpk.org>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Running Bind 9 on Redhat 7
In-Reply-To: <3A913520.3011C7D6@khi.sdnpk.org>
Message-ID: <Pine.LNX.4.32.0102191607400.3627-100000@rossi.itg.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2001, Ansari wrote:

> Hi !!
>
> I am configuring Bind 9 on Redhat 7 but unable to start the named.
> Here is my /var/log message log:

you have a config problem i think.

> Feb 20 09:49:58 ns2 named[2005]: loading zones: no ttl

you need to put:

$TTL <ttl, eg 1D>

at the beginning of each zone file.

oh, you're probably better off asking your questions on a bind
specific list, rather than linux-kernel.

regards,

--paulj



