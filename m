Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267320AbTA1DMx>; Mon, 27 Jan 2003 22:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267322AbTA1DMx>; Mon, 27 Jan 2003 22:12:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63502 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id <S267320AbTA1DMx>;
	Mon, 27 Jan 2003 22:12:53 -0500
Date: Mon, 27 Jan 2003 22:22:24 -0500
From: Christopher Faylor <cgf@redhat.com>
To: kuznet@ms2.inr.ac.ru
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [TEST FIX] Re: SSH Hangs in 2.5.59 and 2.5.55 but not 2.4.x,
Message-ID: <20030128032224.GD18298@redhat.com>
References: <20030127.143625.84825692.davem@redhat.com> <200301280257.FAA27287@sex.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301280257.FAA27287@sex.inr.ac.ru>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2003 at 05:57:55AM +0300, kuznet@ms2.inr.ac.ru wrote:
>>Alexey, this piece of code was buggy first time it was coded, and it
>>may still have some holes.  :-)))
>
>To my shame, I cannot say "no".  It was written sort of too fast.  :-)
>
>Did the reporters see packets with wrong checksum on wire or wrong tcp
>headers or something like that?

My knowledge of TCP/IP is extremely minimal but the sequence number looked
weird when the stall occurred.  It looked like the sequence numbers you get
with the -S option to tcpdump.  All of the other packets had small sequence
numbers and what I assume was the bad packet had a large one.

I'm sorry if this is gibberish and makes no sense.  I don't know how to tell
if the checksum was wrong or not.

cgf
