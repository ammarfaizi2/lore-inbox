Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313415AbSD3M4K>; Tue, 30 Apr 2002 08:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313419AbSD3M4J>; Tue, 30 Apr 2002 08:56:09 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:41723 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S313415AbSD3M4J>; Tue, 30 Apr 2002 08:56:09 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200204301210.g3UC9qX02863@Port.imtp.ilyichevsk.odessa.ua> 
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: "Wanghong Yuan" <wyuan1@ews.uiuc.edu>, linux-kernel@vger.kernel.org
Subject: Re: How to enable printk 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 30 Apr 2002 13:55:17 +0100
Message-ID: <21805.1020171317@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


vda@port.imtp.ilyichevsk.odessa.ua said:
>  It is not silly as long as kernel continues to log tons of normal
> stuff as warnings.

Er, IMO it _is_ silly as long as the kernel continues to log real warnings
as warnings too.

> Here it is: There are way too many printks without a log level! --

Oh, well the answer is obvious - just disable _all_ the warning messages.

Why not turn off KERN_CRIT too, while we're at it? I'm sure we can find at 
least one superfluous KERN_CRIT message.

--
dwmw2


