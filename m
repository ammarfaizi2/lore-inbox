Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267592AbUIUOTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267592AbUIUOTZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 10:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267545AbUIUOTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 10:19:25 -0400
Received: from mailer.campus.mipt.ru ([194.85.82.4]:16090 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S267592AbUIUOS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 10:18:56 -0400
Date: Tue, 21 Sep 2004 18:28:53 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel connector - userspace <-> kernelspace "linker".
Message-Id: <20040921182853.6a104f87@zanzibar.2ka.mipt.ru>
In-Reply-To: <1095769354.30743.64.camel@localhost.localdomain>
References: <1095331899.18219.58.camel@uganda>
	<20040921124623.GA6942@uganda.factory.vocord.ru>
	<1095769354.30743.64.camel@localhost.localdomain>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sep 2004 13:22:35 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Maw, 2004-09-21 at 13:46, Evgeniy Polyakov wrote:
> > Connector driver adds possibility to connect various agents using
> > netlink based network.
> > One must register callback and identificator. When driver receives
> > special netlink message with appropriate identificator, appropriate
> > callback will be called.
> 
> Looks sane enough to me - and it seems to fit the mentality d-bus and
> HAL want to have. 
> 
> Alan
> 
> ps: only trivial item (and really trivial) is that the printk messages
> should be "waiting for %s".

:) Sure. If it will be in the kernel, it will not contain errors.


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
