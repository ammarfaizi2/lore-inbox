Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266917AbTAJTUr>; Fri, 10 Jan 2003 14:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266930AbTAJTUr>; Fri, 10 Jan 2003 14:20:47 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:6547
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266917AbTAJTUq>; Fri, 10 Jan 2003 14:20:46 -0500
Subject: Re: FW: Fastest possible UDMA - how?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Manish Lachwani <m_lachwani@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michael.Knigge@set-software.de
In-Reply-To: <20030110190403.2127.qmail@web20510.mail.yahoo.com>
References: <20030110190403.2127.qmail@web20510.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042229748.32431.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 10 Jan 2003 20:15:48 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-10 at 19:04, Manish Lachwani wrote:
> Take a look at the drive IDENTIFY data. From the ATA
> spec, it can be seen that word# 88 in the IDENTIFY
> data can help you find out the UDMA mode selected and
> UDMA mode supported. 
> 
> The UDMA mode supported is the maximum supported by
> the drive. 

Not always true. There are a wide number of cases where the
UDMA mode being used is not the highest one the drive 
or controller supports. The most simple example is if we 
decide the cabling is not suitable for UDMA66 and higher.


