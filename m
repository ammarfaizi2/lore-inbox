Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751746AbWFCSDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbWFCSDb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 14:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbWFCSDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 14:03:31 -0400
Received: from basillia.speedxs.net ([83.98.255.13]:451 "EHLO
	basillia.speedxs.net") by vger.kernel.org with ESMTP
	id S1751746AbWFCSDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 14:03:30 -0400
Date: Sat, 3 Jun 2006 20:03:25 +0200
From: Tom Wirschell <lkml@wirschell.nl>
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org
Subject: Re: Oops when creating software RAID device (2.6.16.14).
Message-ID: <20060603200325.6bdf5c6e@localhost>
In-Reply-To: <20060602163350.04066047.akpm@osdl.org>
References: <20060602233544.11d46664@localhost>
	<20060602163350.04066047.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02 Jun 2006, Andrew Morton wrote:
> 
> ata_pio_task() oopsed.  Added linux-ide to CC.
> 
> ISTR others hitting this recently.

I upgraded to 2.6.17-rc5-mm2 and dispite a small BUG being reported at
boot by the Marvell SATA driver I was able to create the array and use
it. I'm still testing this setup, but so far it seems to work nicely.

I'll send the maintainer of the Marvell SATA driver the BUG message.

Thanks again.

Kind regards,

Tom Wirschell
I'm not subscribed to LKML or linux-ide, so please CC me in any replies.
-- 
A small child once asked me why people cant be nicer and just love one
another. I pondered this for but a moment and I then, of course, ate
the small child. He was very tangy and did NOT taste like chicken.
	- Lenore 2 -
