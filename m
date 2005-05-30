Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbVE3HQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVE3HQQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 03:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVE3HQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 03:16:16 -0400
Received: from denise.shiny.it ([194.20.232.1]:9900 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S261536AbVE3HQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 03:16:14 -0400
Message-ID: <XFMail.20050530091610.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20050529.135257.98862077.davem@davemloft.net>
Date: Mon, 30 May 2005 09:16:10 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: PATCH : ppp + big-endian = kernel crash
Cc: linux-kernel@vger.kernel.org, phdm@macqel.be
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 29-May-2005 David S. Miller wrote:
>
> And now it will crash when a packet is only 2-byte aligned
> when the input packet processing does the first access
> to the IP address in the packet header.

Accessing 4-byte integers in 2-byte aligned addresses is fine
on all "desktop" CISC m68k IIRC (the first m68k was a 16-bit
processor so it didn't require 32-bit alignment). I don't
know about embedded chips, coldfire and others.


--
Giuliano.
