Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317104AbSFBBdG>; Sat, 1 Jun 2002 21:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317105AbSFBBdF>; Sat, 1 Jun 2002 21:33:05 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:30099 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S317104AbSFBBdE>; Sat, 1 Jun 2002 21:33:04 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sat, 1 Jun 2002 18:44:34 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Louis Garcia <louisg00@bellsouth.net>
cc: William Lee Irwin III <wli@holomorphy.com>, <linux-kernel@vger.kernel.org>
Subject: Re: P4 hyperthreading
In-Reply-To: <1022980463.2427.3.camel@tiger>
Message-ID: <Pine.LNX.4.44.0206011842370.976-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Jun 2002, Louis Garcia wrote:

> Did I forget to say this is a UP box? I just wanted to know if
> hyperthreading is stable for a UP P4 box. Will acpismp=force still help?

CONFIG_SMP must be on. the fact that you have a single CPU does not mean
that spinlocks have to resolve to {} with ht



- Davide


