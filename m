Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317213AbSFCFjy>; Mon, 3 Jun 2002 01:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317279AbSFCFjx>; Mon, 3 Jun 2002 01:39:53 -0400
Received: from goliath.siemens.de ([192.35.17.28]:4561 "EHLO
	goliath.siemens.de") by vger.kernel.org with ESMTP
	id <S317213AbSFCFjv>; Mon, 3 Jun 2002 01:39:51 -0400
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: "'Keith Owens'" <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Decoding of addreses in kernel logs 
Date: Mon, 3 Jun 2002 09:39:41 +0400
Message-ID: <6134254DE87BD411908B00A0C99B044F02E89B5A@mowd019a.mow.siemens.ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <28024.1022742421@kao2.melbourne.sgi.com>
x-mimeole: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 30 May 2002 10:57:50 +0400,
> Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru> wrote:
> >Are there any cases except oopses when decoding of addresses in
kernel logs
> >is needed? The reason is I'd like to switch from klogd+syslogd to
other
> >logging system and I was adviced to forget klogd and just get logs
from
> >/proc/kmsg and decode them with ksymoops. While I have no problem
with it
> >actually, my concern is - is it possible that some information in
kernel
> >logs can be decoded by klogd but not by ksymoops?
> 
> It is the other way around.  ksymoops decodes far more than klogd
does.
> ksymoops has been continually extended as new diagnostics are added to
> the kernel, klogd has not.

Thank you. My only concern is that klogd decodes addresses in real time
(if it is able to do it at all) while ksymoops is usually postmortem. It
means that ksymoops may not have access to real module addresses? 

-andrej

