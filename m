Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317540AbSFKU7k>; Tue, 11 Jun 2002 16:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317541AbSFKU7j>; Tue, 11 Jun 2002 16:59:39 -0400
Received: from www.aub.dk ([195.24.1.195]:6528 "EHLO Princess")
	by vger.kernel.org with ESMTP id <S317540AbSFKU7i>;
	Tue, 11 Jun 2002 16:59:38 -0400
From: Allan Sandfeld Jensen <snowwolf@one2one-networks.com>
Organization: One2one Networks A/S
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bandwidth 'depredation' revisited
Date: Tue, 11 Jun 2002 22:59:19 +0200
User-Agent: KMail/1.4.5
In-Reply-To: <3D05EEAF.mailZE11URHZ@viadomus.com> <3D060FF6.5000409@fugmann.dhs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200206112259.19131.snowwolf@one2one-networks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 June 2002 16:57, Anders Fugmann wrote:
> When you start a big download, you actually request a server to send as
> much data as possible to you. Quickly, the packet queues on your ISP's
> side gets filled up. If these queues are big (can hold many packets) you
> will see a rather high latency when trying to retrieve replys, since any
> pakcets (incl. ACK) will need first to enter the queue, and wait for
> their turn to be send to you.
>
> The best solution would be to install some sort of traffic shaping on
> the remove side (you ISP), but that is often(/always) not a possible
> solution.
>
> The second best solution is to simple drop packets comming in too 
> quickly from the interface. By this, the sending machine will slow down 
> transmission. The idea is to keep the queues at you ISP empty.

You could also just delay trafic from certain IPs. Or even better, you could 
postpone acknowledgedments until you get the right distribution.

I know routers that do the former to gain fair download on shared internet 
connections, but the second would be a lot nicer.
