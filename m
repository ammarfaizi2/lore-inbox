Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278309AbRJWVf4>; Tue, 23 Oct 2001 17:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278311AbRJWVfq>; Tue, 23 Oct 2001 17:35:46 -0400
Received: from freeside.toyota.com ([63.87.74.7]:20752 "EHLO toyota.com")
	by vger.kernel.org with ESMTP id <S278309AbRJWVfj>;
	Tue, 23 Oct 2001 17:35:39 -0400
Message-ID: <3BD5E2C5.26F5A133@lexus.com>
Date: Tue, 23 Oct 2001 14:36:05 -0700
From: J Sloan <jjs@lexus.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: DevilKin <DevilKin@gmx.net>
CC: bill davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: More memory == better?
In-Reply-To: <20011023161340.02EAC9BD76@pop3.telenet-ops.be> <fRjB7.3865$bi5.656765064@newssvr17.news.prodigy.com> <20011023200715.AEF66217593@tartarus.telenet-ops.be>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DevilKin wrote:

> On Tuesday 23 October 2001 21:49, bill davidsen wrote:
>
> > Just remember that to use this memory you need a large memory kernel.
>
> Ah, thats with HIGHMEM support? I've read a lot of awful things about it
> here... how stable (aka usable) is it?

I have 2 observations -

If you don't enable highmem support, you'll
be able to use about 960 MB of your 1 GB -
no big loss, right?

I've been running on a couple machines
with SMP and the 4 GB option, and they
seem quite stable (there was a highmem
bug in the preempt patch, but that is fixed
in the most recent release)

All things considered, it works quite well.

cu

jjs

