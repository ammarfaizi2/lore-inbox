Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316674AbSIED6L>; Wed, 4 Sep 2002 23:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316682AbSIED6L>; Wed, 4 Sep 2002 23:58:11 -0400
Received: from dsl-213-023-038-092.arcor-ip.net ([213.23.38.92]:31395 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316674AbSIED6K>;
	Wed, 4 Sep 2002 23:58:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: Large block device patch, part 1 of 9
Date: Thu, 5 Sep 2002 06:05:17 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <825516963@toto.iv> <E17mkfj-000627-00@starship> <20020904213156.A6367@redhat.com>
In-Reply-To: <20020904213156.A6367@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17mntN-000642-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 September 2002 03:31, Benjamin LaHaise wrote:
> On Thu, Sep 05, 2002 at 02:38:58AM +0200, Daniel Phillips wrote:
> > The thing is, I don't see why we should be building castles and cathedrals
> > around printk.  Just cast to the wider value, if you get it wrong you have
> > lost exactly what?  Are people feeding the output of dmesg into scripts
> > that their systems depend upon?  If so, we need to let evolution do its
> > work.
> 
> Why do it the broken way when you can do it a non-broken way?  Arguing in 
> favour of having it broken by design isn't something I really understand.  

Because you're only fixing the printk, and with an inadequate solution at
that.  Could we please fix something that matters?

-- 
Daniel
