Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266434AbTAJTSo>; Fri, 10 Jan 2003 14:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266425AbTAJTSo>; Fri, 10 Jan 2003 14:18:44 -0500
Received: from web20502.mail.yahoo.com ([216.136.226.137]:37641 "HELO
	web20502.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S266417AbTAJTSm>; Fri, 10 Jan 2003 14:18:42 -0500
Message-ID: <20030110192727.63417.qmail@web20502.mail.yahoo.com>
Date: Fri, 10 Jan 2003 11:27:27 -0800 (PST)
From: Manish Lachwani <m_lachwani@yahoo.com>
Subject: Re: FW: Fastest possible UDMA - how? 
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org, Michael.Knigge@set-software.de
In-Reply-To: <200301101921.h0AJLFLK012541@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the drives support UDMA 2, then the controller will
operate in UDMA 2. In that case, the IDENTIFY
information will show UDMA 2 for UDMA mode selected
and UDMA 2 for UDMA mode supported.

Now, say that I have a drive that supports UDMA 6 and
the controller supports UDMA 5. Then, from the
IDENTIFY information, the UDMA selected would be UDMA
5 while the UDMA supported would be UDMA 6.

Thanks
manish
--- Valdis.Kletnieks@vt.edu wrote:
> On Fri, 10 Jan 2003 11:04:03 PST, Manish Lachwani
> <m_lachwani@yahoo.com>  said:
> > Take a look at the drive IDENTIFY data. From the
> ATA
> > spec, it can be seen that word# 88 in the IDENTIFY
> > data can help you find out the UDMA mode selected
> and
> > UDMA mode supported. 
> > 
> > The UDMA mode supported is the maximum supported
> by
> > the drive. 
> 
> Will this DTRT if the IDE *controller* does UDMA-5
> but the drives are UDMA-2
> at best?
> 

> ATTACHMENT part 2 application/pgp-signature 



__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
