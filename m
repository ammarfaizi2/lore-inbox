Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270625AbTHEUTg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 16:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270647AbTHEUTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 16:19:36 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:24580 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S270625AbTHEUTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 16:19:35 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Adrian Bunk <bunk@fs.tum.de>, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [patch] 2.4.22-pre10: fix circular dependency
Date: Tue, 5 Aug 2003 22:19:04 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0308011316490.3656-100000@logos.cnet> <20030803131630.GW16426@fs.tum.de>
In-Reply-To: <20030803131630.GW16426@fs.tum.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200308052218.41588.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 03 August 2003 15:16, Adrian Bunk wrote:

Hi Adrian,

> >   o Fix irq handling of IO-APIC edge IRQs on UP
> This patch adds for no good reason two #include's to
> include/asm-i386/hw_irq.h resulting in a circular dependency between
> headers.
grmpf, yeah. right. Sorry :(

ciao, Marc

