Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265570AbTBFFjT>; Thu, 6 Feb 2003 00:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265589AbTBFFjT>; Thu, 6 Feb 2003 00:39:19 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:60560 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S265570AbTBFFjS>; Thu, 6 Feb 2003 00:39:18 -0500
Date: Wed, 5 Feb 2003 23:48:48 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Andrew Morton <akpm@digeo.com>
cc: scott-kernel@thomasons.org, Jaroslav Kysela <perex@suse.cz>,
       <linux-kernel@vger.kernel.org>
Subject: Re: soundcard bug in 2.5.59-mm8
In-Reply-To: <20030205163243.3b63e810.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0302052342170.17208-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Feb 2003, Andrew Morton wrote:

> > There's an error in the link process when trying to use the 
> > ES1968 driver. I haven't ever tried it on previous kernels, but 
> > when this one blew, I checked it against vanilla 2.5.59, and it 
> > finished fine there. Output and config options below. Let me 
> > know if you need more.
> 
> The -mm patches include the lates from Linus's repository.  There is a large
> change to sound/core/seq/Makefile there.  Seems that Kai was there ;)

I plead not guilty ;-)

I only removed the export-objs statement, the more substantial changes
were done by Jaroslav (which, btw, I'm not happy too happy with - the rest
of the kernel gets along with the standard statements, I'm not sure
there's a good reason ALSA does things differently.)

--Kai


