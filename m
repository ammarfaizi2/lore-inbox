Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269187AbTCBLkK>; Sun, 2 Mar 2003 06:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269189AbTCBLkK>; Sun, 2 Mar 2003 06:40:10 -0500
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:23205 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S269187AbTCBLkJ>;
	Sun, 2 Mar 2003 06:40:09 -0500
From: Con Kolivas <kernel@kolivas.org>
To: alexander.riesen@synopsys.COM
Subject: Re: 2.4.20-ck4
Date: Sun, 2 Mar 2003 22:50:32 +1100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200302281545.01222.kernel@kolivas.org> <20030228124314.GS5239@riesen-pc.gr05.synopsys.com>
In-Reply-To: <20030228124314.GS5239@riesen-pc.gr05.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303022250.32234.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2003 11:43 pm, Alex Riesen wrote:
> Con Kolivas, Fri, Feb 28, 2003 05:45:01 +0100:
> > I've updated my patchset
> >
> > It includes:
> > O(1) scheduler
> > Preempt
> > Low Latency
> > AA VM addons
> > Read Latency2
> > SuperMount
> > XFS
> > ACPI
> > DVD/CDRW packet writing
> > Desktop Tuning
> > optional extras:
> > Compressed caching
> > Rmap15d
>
> You do not include ALSA anymore. Is that just because of lack of time,
> or did i miss some serious problem with it?

The alsa patches I had available were simply a backport of 0.90rc2 from 2.5.
Since alsa is now up to 0.90rc7 they were getting old, and a new backport 
would require some effort. There isn't much point to doing this since the 
only real benefit to patching it into the kernel directly is having the 
ability to compile it into the kernel instead of as modules. You can easily 
enough compile the modules after the kernel is compiled.

> Thanks for you patches, anyway

A pleasure, enjoy!

Con
