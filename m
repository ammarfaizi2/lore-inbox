Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbWCZQVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbWCZQVL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 11:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWCZQVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 11:21:11 -0500
Received: from science.horizon.com ([192.35.100.1]:30768 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751406AbWCZQVK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 11:21:10 -0500
Date: 26 Mar 2006 11:21:00 -0500
Message-ID: <20060326162100.9204.qmail@science.horizon.com>
From: linux@horizon.com
To: dedekind@yandex.ru, linux@horizon.com
Subject: Re: Lifetime of flash memory
Cc: kalin@thinrope.net, linux-kernel@vger.kernel.org
In-Reply-To: <44269D47.3010703@yandex.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> some time ago I tried to find any documentation about CF internals, but 
> failed. It seems like you may hint me where to find it, may you?

Sorry, I don't have anything in particular, just bits I've picked up
talking to CF manufacturers.

Basically, a CF card is a flash ROM array attached to a little
microcontroller with an IDE interface.  The large manufacturers generally
have custom controllers.

A basic block diagram is on page 3 (physical page 19) of the
CompactFlash spec, available from
http://www.compactflash.org/cfspc3_0.pdf
