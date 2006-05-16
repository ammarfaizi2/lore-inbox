Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWEPRlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWEPRlr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 13:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWEPRlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 13:41:46 -0400
Received: from relay00.pair.com ([209.68.5.9]:40210 "HELO relay00.pair.com")
	by vger.kernel.org with SMTP id S932173AbWEPRlq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 13:41:46 -0400
X-pair-Authenticated: 71.197.50.189
Date: Tue, 16 May 2006 12:41:44 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>
cc: linux-kernel@vger.kernel.org
Subject: Re: events/0 eats 100% cpu on core duo laptop
In-Reply-To: <Pine.LNX.4.64.0605162002150.9606@tassadar.physics.auth.gr>
Message-ID: <Pine.LNX.4.64.0605161237210.32181@turbotaz.ourhouse>
References: <Pine.LNX.4.64.0605162002150.9606@tassadar.physics.auth.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2006, Dimitris Zilaskos wrote:

>
> 	Hello ,
>
> I have installed Slackware 10.2 on a fujitsu siemens e8110 laptop (Core Duo). 
> With 2.6.16.12 & 2.6.16.16 kernels, a few minutes after boot events/0 starts 
> eating 100% cpu (affecting performance and battery life).
> 	 Any ideas ?

events is used for a lot of things. Can you send lspci and dmesg 
output? Can you try leaving the system totally idle (no network traffic, etc) for 
a while and see if that delay before events begins looping is affected?

Do you have an earlier or later kernel release you can test/confirm as
affected or unaffected? It's not much fun, but if you can find a kernel 
that properly works, it's always possible to do a bisect...

>
> 	Best regards ,
> --
> ============================================================================
>
> Dimitris Zilaskos

Thanks,
Chase
