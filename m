Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267678AbUIUNZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267678AbUIUNZF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 09:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267681AbUIUNZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 09:25:04 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:11227 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267678AbUIUNZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 09:25:01 -0400
Subject: Re: Kernel connector - userspace <-> kernelspace "linker".
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040921124623.GA6942@uganda.factory.vocord.ru>
References: <1095331899.18219.58.camel@uganda>
	 <20040921124623.GA6942@uganda.factory.vocord.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095769354.30743.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 21 Sep 2004 13:22:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-21 at 13:46, Evgeniy Polyakov wrote:
> Connector driver adds possibility to connect various agents using
> netlink based network.
> One must register callback and identificator. When driver receives
> special netlink message with appropriate identificator, appropriate
> callback will be called.

Looks sane enough to me - and it seems to fit the mentality d-bus and
HAL want to have. 

Alan

ps: only trivial item (and really trivial) is that the printk messages
should be "waiting for %s".

