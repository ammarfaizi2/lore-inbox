Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S266864AbUJVSyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266864AbUJVSyj (ORCPT <rfc822;akpm@zip.com.au>);
	Fri, 22 Oct 2004 14:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266561AbUJVSvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 14:51:53 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:59045 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S266519AbUJVSrO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 14:47:14 -0400
Message-ID: <417955AF.6010904@free.fr>
Date: Fri, 22 Oct 2004 20:47:11 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: eric.valette@free.fr
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SCSI adaptec 2940 : problem since 2.6.9 and up to 2.6.9-bk6
References: <4178BFCC.50804@free.fr>
In-Reply-To: <4178BFCC.50804@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Valette wrote:
> Here is the log message I get :
> 
> scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
>         <Adaptec 2940 Ultra SCSI adapter>
>         aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs
> 
> (scsi0:A:3:0): Unexpected busfree in Message-out phase
> SEQADDR == 0x16f
> (scsi0:A:3:0): Unexpected busfree in Message-out phase
> SEQADDR == 0x16f
> (scsi0:A:3:0): Unexpected busfree in Message-out phase
> SEQADDR == 0x16f
> 
> several ten's of such lines removed
> ...

After some more investigation  it looks like a hardware problem on the 
DAT itself. I hven't touched it for years (maybe too many...) and saw 
the complaint and the recent change so I was rather sure it was the 
driver/scsi layer changes .

So forget it,

-- eric

