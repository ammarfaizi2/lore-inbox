Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbVLTGpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbVLTGpR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 01:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbVLTGpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 01:45:17 -0500
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:2486 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750818AbVLTGpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 01:45:16 -0500
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: SPI core function names
Date: Mon, 19 Dec 2005 22:45:15 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <43A6886F.6090606@ru.mvista.com>
In-Reply-To: <43A6886F.6090606@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512192245.15170.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 December 2005 2:16 am, Vitaly Wool wrote:
> HI David,
> 
> one of the guys working on the SPI stuff with me noticed that he didn't 
> feel conmortable with spi_sync name as it could be confused with the 
> function that synchronizes between something and something else. So what 
> if change spi_sync/spi_async to spi_transfer_sync/spi_transfer_async?

Sure, feel free to submit a patch changing that the places they're used
in the 2.6.15-rc5-mm3 SPI patches.  (Plus the four patches I've sent
since then...)  The only downside to this change is breaking builds!

- Dave

