Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261394AbSKBUtA>; Sat, 2 Nov 2002 15:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261404AbSKBUtA>; Sat, 2 Nov 2002 15:49:00 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:29451 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261394AbSKBUs7>; Sat, 2 Nov 2002 15:48:59 -0500
Message-Id: <200211022050.gA2KoJp25950@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Jos Hulzink <josh@stack.nl>, Stas Sergeev <stssppnn@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Larger IO bitmap?
Date: Sat, 2 Nov 2002 23:42:19 -0200
X-Mailer: KMail [version 1.3.2]
References: <3DC417A4.2000903@yahoo.com> <200211022248.11869.josh@stack.nl>
In-Reply-To: <200211022248.11869.josh@stack.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 November 2002 19:48, Jos Hulzink wrote:
> Hi,
>
> Increasing the IO bitmap size has huge effects on your Task State
> Segment size. It sure is possible to increase that size, but be aware
> that this means you are using megabytes for your TSS's only !

We have per-CPU TSS, not per task
--
vda
