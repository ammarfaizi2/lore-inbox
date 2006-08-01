Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWHAX0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWHAX0A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 19:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWHAX0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 19:26:00 -0400
Received: from [81.2.110.250] ([81.2.110.250]:26329 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750741AbWHAX0A convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 19:26:00 -0400
Subject: Re: [2.6.18-rc2-mm1] pata_via fails
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "J.A." =?ISO-8859-1?Q?Magall=F3n?= <jamagallon@ono.com>
Cc: "Linux-Kernel," <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
In-Reply-To: <20060802010415.2bebc5fc@werewolf.auna.net>
References: <20060802010415.2bebc5fc@werewolf.auna.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Wed, 02 Aug 2006 00:45:05 +0100
Message-Id: <1154475905.15540.121.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-02 am 01:04 +0200, ysgrifennodd J.A. Magallón:
> Yes, generic subject ;)
> 
> After solving the problems with ICH, one other stays. One box has a
> VIA controller (in fact, this is a ApolloPro 266 chipset motherboard):

Known insanity. With some ATAPI devices the VIA delivers the IRQ before
the response is ready when we do a SET_FEATURES. Still being worked on.

Alan

