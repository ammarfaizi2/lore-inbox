Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314035AbSDZOAD>; Fri, 26 Apr 2002 10:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314043AbSDZOAC>; Fri, 26 Apr 2002 10:00:02 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:32009 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S314035AbSDZOAC>; Fri, 26 Apr 2002 10:00:02 -0400
Date: Fri, 26 Apr 2002 17:54:37 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: thunder7@xs4all.nl, linux-kernel@vger.kernel.org
Subject: Re: PDC20265 / 2.5.10 / Alpha (Miata) - unexpected interrupt flood
Message-ID: <20020426175437.C22347@jurassic.park.msu.ru>
In-Reply-To: <20020426120107.GA9344@alpha.of.nowhere> <3CC93517.8020503@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2002 at 01:08:07PM +0200, Martin Dalecki wrote:
> It will happen if the interrupt in question is shared
> among different devices for example.

There are no shared interrupts on this machine (as on most alphas).
Each PCI slot has four unique IRQs.

Ivan.
