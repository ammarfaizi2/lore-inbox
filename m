Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313304AbSD3MiU>; Tue, 30 Apr 2002 08:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313307AbSD3MiT>; Tue, 30 Apr 2002 08:38:19 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:48399 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S313304AbSD3MiR>; Tue, 30 Apr 2002 08:38:17 -0400
Message-Id: <200204301210.g3UC9qX02863@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: David Woodhouse <dwmw2@infradead.org>,
        "Wanghong Yuan" <wyuan1@ews.uiuc.edu>
Subject: Re: How to enable printk
Date: Tue, 30 Apr 2002 15:12:14 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <001001c1ef3d$890a6d50$e6f7ae80@ad.uiuc.edu> <20020428.204911.63038910.davem@redhat.com> <29915.1020080236@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 April 2002 09:37, David Woodhouse wrote:
> wyuan1@ews.uiuc.edu said:
> >  It may be a simple question. But I cannot see the result of printk in
> > console like the following. Do i need to enable it somewhere? Thanks
>
> You didn't give a priority, so it will have defaulted to KERN_WARNING.
>
> Some distributions disable the logging of KERN_WARNING messages to the
> console, which seems to be a very silly thing to do.

It is not silly as long as kernel continues to log tons of normal stuff
as warnings.

> file a bug report.

Here it is:
There are way too many printks without a log level!
--
vda
