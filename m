Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269290AbUJFPRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269290AbUJFPRU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 11:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269289AbUJFPRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 11:17:19 -0400
Received: from chaos.analogic.com ([204.178.40.224]:7552 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S269292AbUJFPPj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 11:15:39 -0400
Date: Wed, 6 Oct 2004 11:15:13 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "David S. Miller" <davem@davemloft.net>
cc: Joris van Rantwijk <joris@eljakim.nl>, linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
In-Reply-To: <20041006080104.76f862e6.davem@davemloft.net>
Message-ID: <Pine.LNX.4.61.0410061110260.6661@chaos.analogic.com>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl>
 <20041006080104.76f862e6.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2004, David S. Miller wrote:

> On Wed, 6 Oct 2004 16:52:27 +0200 (CEST)
> Joris van Rantwijk <joris@eljakim.nl> wrote:
>
>> My understanding of POSIX is limited, but it seems to me that a read call
>> must never block after select just said that it's ok to read from the
>> descriptor. So any such behaviour would be a kernel bug.
>
> There is no such guarentee.

Huh?  Then why would anybody use select()?  It can't return a
'guess" or it's broken. When select() or poll() claims that
there are data available, there damn well better be data available
or software becomes a crap-game. And, if you've decided that
such a game-of-chance is okay then please keep your software
out of the new Ethernet Avionics Buses that Airbus now is using.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.5-1.358-noreg on an i686 machine (5537.79 BogoMips).
             Note 96.31% of all statistics are fiction.

