Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313549AbSDQLG0>; Wed, 17 Apr 2002 07:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313536AbSDQLGZ>; Wed, 17 Apr 2002 07:06:25 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:57872 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S313549AbSDQLGX>; Wed, 17 Apr 2002 07:06:23 -0400
Date: Wed, 17 Apr 2002 13:05:28 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: bert hubert <ahu@ds9a.nl>
cc: Olaf Fraczyk <olaf@navi.pl>, <linux-kernel@vger.kernel.org>
Subject: Re: please merge 64-bit jiffy patches.
In-Reply-To: <20020417102828.D11817@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.33.0204171258310.14333-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2002, bert hubert wrote:

> I feel your pain 
> 
> 4:26am  up 482 days, 10:33,  2 users,  load average: 0.04, 0.02, 0.00
> 
> On a very remote server.
> 
> So can we please merge the 64-bit jiffies patches? I sometimes think that
> that is the main reason why alpha DOES have HZ=1024 - the jiffies there
> don't wrap in an embarrassing way within two months :-)
> 

Rik van Riel correctly suggested to merge it in 2.5 first. I have a 
forward-ported version, but it has a minor locking issue on UP.

Albert Cahalan suggested to get rid of locking at all by only updating the 
high word from the timer interupt. I will try to code this on the weekend.

I'm sorry I had no time for lobbying the merge in the last month.

Tim




