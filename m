Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274544AbRITPu6>; Thu, 20 Sep 2001 11:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274545AbRITPut>; Thu, 20 Sep 2001 11:50:49 -0400
Received: from [128.165.17.254] ([128.165.17.254]:30429 "EHLO
	balance.radtt.lanl.gov") by vger.kernel.org with ESMTP
	id <S274544AbRITPum>; Thu, 20 Sep 2001 11:50:42 -0400
Date: Thu, 20 Sep 2001 09:50:56 -0600
From: Eric Weigle <ehw@lanl.gov>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: nalabi@formail.org, linux-kernel@vger.kernel.org
Subject: Re: qlogic driver , 1Tbyte hard error
Message-ID: <20010920095056.A21993@lanl.gov>
In-Reply-To: <E15k3FD-0005E1-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15k3FD-0005E1-00@the-village.bc.nu>
User-Agent: Mutt/1.3.18i
X-Eric-Unconspiracy: There ought to be a conspiracy
X-Editor: Vim, http://www.vim.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The maximum supported file system size under Linux 2.4 is just under 1Tb.
> The scsi layer gets slightly confused a bit earlier with its printk messages
Is there any particular (that is, technical) reason for this?  A few months
ago I hit this problem while building a RAID system for our group.  We wanted
to do software RAID-0 over three hardware RAID-5 arrays (2 by 375G and one
525G) and the kernel (2.4.6) had a hissy fit.

Given the relatively low cost of disk space ($5000/terabyte and on up, see
http://staff.sdsc.edu/its/terafile/), is this something that will be supported
in the future?

If you point me in the right direction I'd be willing to look at this issue.


Thanks
-Eric

-- 
--------------------------------------------
 Eric H. Weigle   CCS-1, RADIANT team
 ehw@lanl.gov     Los Alamos National Lab
 (505) 665-4937   http://home.lanl.gov/ehw/
--------------------------------------------
