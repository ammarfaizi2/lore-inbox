Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268963AbRHFTkn>; Mon, 6 Aug 2001 15:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268960AbRHFTkc>; Mon, 6 Aug 2001 15:40:32 -0400
Received: from [206.17.46.85] ([206.17.46.85]:54999 "EHLO titania.wins.hrl.com")
	by vger.kernel.org with ESMTP id <S268966AbRHFTka>;
	Mon, 6 Aug 2001 15:40:30 -0400
Date: Mon, 6 Aug 2001 14:45:42 -0700 (PDT)
From: Samarth Shah <shshah@wins.hrl.com>
To: <linux-kernel@vger.kernel.org>
Subject: packet forwarding question
Message-ID: <Pine.LNX.4.33.0108061437220.4169-100000@tempest.wins.hrl.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would like to do some processing on packets that are being forwarded by
a linux box configured for IPv4 forwarding. I understand that, at the end
of ip_input.c, the input function pointer of the dst_entry points to the
function that will be doing the forwarding.

I would like to know what is the name of this function. How do I do some
processing on the packet, so that my code is executed only when the packet
is going to be forwarded and not if this host is the sender or receiver?

My guess was that if I can know what function skb->dst->input points to in
the case of packet forwarding, I can call my code from within that
function. But perhaps that's not right and there's a better way...

Any help would be appreciated.

Thanks and regards,
Samarth.

