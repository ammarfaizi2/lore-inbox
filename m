Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318914AbSIITEA>; Mon, 9 Sep 2002 15:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318915AbSIITD7>; Mon, 9 Sep 2002 15:03:59 -0400
Received: from dsl-213-023-039-209.arcor-ip.net ([213.23.39.209]:51135 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318914AbSIITD6>;
	Mon, 9 Sep 2002 15:03:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: root@chaos.analogic.com
Subject: Re: Calculating kernel logical address ..
Date: Mon, 9 Sep 2002 20:50:38 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Imran Badr <imran.badr@cavium.com>, "'David S. Miller'" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.3.95.1020909144217.18372A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1020909144217.18372A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17oTcN-0006sn-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 September 2002 20:43, Richard B. Johnson wrote:
> On Mon, 9 Sep 2002, Daniel Phillips wrote:
> 
> > On Monday 09 September 2002 20:00, Richard B. Johnson wrote:
> > > For some reason, (claimed performance reasons) user-mode code
> > > has to be able to get data directly from hardware with no
> > > intervening copy operation. I think any claimed advantage goes
> > > away when you look at the overhead necessary for user-mode
> > > code to sleep before, and awaken after, the DMA operation but
> > > often marketing departments make those decisions.
> > 
> > Pfft.  Try turning off ide dma and see what happens.
> 
> I know that DMA works, I'm talking about DMA direct-to-user
> which is not what the file-systems that use DMA do.

The next generation of fast, parallel filesystems relies on dma
to/from user space.  Besides, what do you think happens when you
read/write a mmap?

-- 
Daniel
