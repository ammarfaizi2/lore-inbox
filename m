Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267057AbTAJS7v>; Fri, 10 Jan 2003 13:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267039AbTAJS65>; Fri, 10 Jan 2003 13:58:57 -0500
Received: from web20510.mail.yahoo.com ([216.136.226.145]:3882 "HELO
	web20510.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S266257AbTAJSzS>; Fri, 10 Jan 2003 13:55:18 -0500
Message-ID: <20030110190403.2127.qmail@web20510.mail.yahoo.com>
Date: Fri, 10 Jan 2003 11:04:03 -0800 (PST)
From: Manish Lachwani <m_lachwani@yahoo.com>
Subject: Re: FW: Fastest possible UDMA - how?
To: linux-kernel@vger.kernel.org, Michael.Knigge@set-software.de
In-Reply-To: <233C89823A37714D95B1A891DE3BCE5202AB1B88@xch-a.win.zambeel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Take a look at the drive IDENTIFY data. From the ATA
spec, it can be seen that word# 88 in the IDENTIFY
data can help you find out the UDMA mode selected and
UDMA mode supported. 

The UDMA mode supported is the maximum supported by
the drive. 

Thanks
Manish

> Hi all,
> 
> is it somehow possible to determine what is the
> fastest UDMA-Mode my 
> IDE-Controller supports - independant of the
> chipset?
> 
> Thanks,
>   Michael
> 
> 
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
