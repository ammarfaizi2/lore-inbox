Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbVHIQRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbVHIQRZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 12:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbVHIQRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 12:17:25 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:56521 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S964859AbVHIQRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 12:17:24 -0400
Subject: Re: irqpoll causing some breakage?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hans-Christian Armingeon <mog.johnny@gmx.net>
Cc: Daniel Drake <dsd@gentoo.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200508091057.22712.mog.johnny@gmx.net>
References: <42F7FD5E.6000107@gentoo.org>
	 <200508091057.22712.mog.johnny@gmx.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 09 Aug 2005 17:44:03 +0100
Message-Id: <1123605844.15600.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-08-09 at 10:57 +0200, Hans-Christian Armingeon wrote:
> PortA --- Keyboard with integrated mouse
> PortB --- Hub
> HubPortA --- Mouse
> HubPortA --- Trackball
> 
> The mice don't work, when I plug them directly into Port A or B .
> 
> The keyboard works ervery time.

Then its not irqpoll related because the keyboard and mouse are using
the same IRQ in some of the cases you describe.

