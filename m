Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284282AbRLBTM3>; Sun, 2 Dec 2001 14:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284280AbRLBTMU>; Sun, 2 Dec 2001 14:12:20 -0500
Received: from camus.xss.co.at ([194.152.162.19]:51728 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id <S284281AbRLBTMF>;
	Sun, 2 Dec 2001 14:12:05 -0500
Message-ID: <3C0A7CF6.3304AD83@xss.co.at>
Date: Sun, 02 Dec 2001 20:11:50 +0100
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: arrays@compaq.com, linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au
Subject: Re: [PATCH] missing gendisk initialization in cpqarray.c (Linux-2.2.20)
In-Reply-To: <E16AbqW-0004Bt-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > The following patch adds code to initialize gendisk.fops
> > in cpqarray.c. It's needed to avoid a kernel warning message
> > when using devfs with the Compaq RAID Controller.
> >
> > --- linux-2.2.20/drivers/block/cpqarray.c       Fri Nov  2 17:39:06
> > 2001
> 
> Im confused. Linux 2.2 doesn't include devfs. This patch therefore seems
> nonsense

Hm, ok...

Then this patch (and the one for cciss.c) should better 
go to Richard for inclusion in the 2.2.20 devfs patch?

Regards,

- andreas

-- 
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
