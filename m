Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265437AbSJXNBf>; Thu, 24 Oct 2002 09:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265438AbSJXNBf>; Thu, 24 Oct 2002 09:01:35 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:38157 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S265437AbSJXNBe>; Thu, 24 Oct 2002 09:01:34 -0400
Message-Id: <200210241249.g9OCnOp09750@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [RESEND] tuning linux for high network performance?
Date: Thu, 24 Oct 2002 15:41:59 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, netdev@oss.sgi.com,
       Kernel mailing list <linux-kernel@vger.kernel.org>
References: <200210231218.18733.roy@karlsbakk.net> <200210241129.g9OBTpp09266@Port.imtp.ilyichevsk.odessa.ua> <20021024125030.A7529@flint.arm.linux.org.uk>
In-Reply-To: <20021024125030.A7529@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 October 2002 09:50, Russell King wrote:
> On Thu, Oct 24, 2002 at 02:22:25PM -0200, Denis Vlasenko wrote:
> > Please delete memory.o, rerun make bzImage, capture gcc
> > command used for compiling memory.c, modify it:
> >
> > gcc ... -o memory.o  ->  gcc ... -S -o memory.s ...
>
> Have you tried make mm/memory.s ?

No ;) but I have a feeling it will produce that file ;)))

I'm experimenting with different csum_ routines in userspace now.
--
vda
