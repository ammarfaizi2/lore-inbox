Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311211AbSCZLup>; Tue, 26 Mar 2002 06:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311212AbSCZLuf>; Tue, 26 Mar 2002 06:50:35 -0500
Received: from gold.MUSKOKA.COM ([216.123.107.5]:268 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S311211AbSCZLuT>;
	Tue, 26 Mar 2002 06:50:19 -0500
Message-ID: <3CA05B75.3FA00CC1@yahoo.com>
Date: Tue, 26 Mar 2002 06:28:53 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
MIME-Version: 1.0
To: David Weinehall <tao@acc.umu.se>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Announcement] patch-2.0.40-rc4
In-Reply-To: <20020317135322.J3301@khan.acc.umu.se> <E16meOv-0002xY-00@the-village.bc.nu> <20020326111424.A16636@khan.acc.umu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall wrote:
> 
> On Sun, Mar 17, 2002 at 05:24:57PM +0000, Alan Cox wrote:
> > > o   Commented out a printk in fs/buffer.c   (Michael Deutschmann)
> > >     that complains about mismatching
> > >     blocksizes
> >
> > Erm.. why ?? It seems to be correctly complaining for a reason
> 
> According to Michael Deutschmann, who still uses v2.0 actively (and gets
> this message a lot), the code seems to do the right thing despite the
> complaint; hence the message seemed unnecessary.

Assuming the message is meaningful, rate limit the number of
times the user sees it.  Or rate limit on time, which ever seems 
more appropriate.

Paul.


