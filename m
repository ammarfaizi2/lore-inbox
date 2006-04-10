Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWDJVG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWDJVG5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 17:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWDJVG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 17:06:57 -0400
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:26769 "HELO
	smtp105.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751197AbWDJVG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 17:06:56 -0400
From: David Brownell <david-b@pacbell.net>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [spi-devel-general] [PATCH][2.16.17-rc1-mm2] spi: Added spi master driver for Freescale MPC83xx SPI controller
Date: Mon, 10 Apr 2006 14:06:54 -0700
User-Agent: KMail/1.7.1
Cc: Vitaly Wool <vitalywool@gmail.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
References: <Pine.LNX.4.44.0604101414500.5501-100000@gate.crashing.org> <443ABA1A.1060801@gmail.com> <EB5A4A6A-BCD0-4DD0-A0F4-E155495EDCC6@kernel.crashing.org>
In-Reply-To: <EB5A4A6A-BCD0-4DD0-A0F4-E155495EDCC6@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604101406.55269.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 April 2006 1:22 pm, Kumar Gala wrote:
> 

> I wasn't particular happy about the spinning for ever, wasn't sure  
> what would be better.  I need to ensure we've gotten both a TX & RX  
> event before transmitting the next character.  I'm open to  
> suggestions on how to do this better.

I figured that it's impossible to get an RX event without the TX
having completed.  :)

- Dave

