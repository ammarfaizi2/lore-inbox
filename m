Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWHPSm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWHPSm3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 14:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWHPSm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 14:42:28 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:35516 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750716AbWHPSm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 14:42:28 -0400
Date: Wed, 16 Aug 2006 20:42:31 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CROSS_COMPILE issue
Message-ID: <20060816184231.GC5852@mars.ravnborg.org>
References: <20060816164036.32867.qmail@web25805.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816164036.32867.qmail@web25805.mail.ukl.yahoo.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 04:40:36PM +0000, moreau francis wrote:
> Hi
> 
> I met an issue when compiling kernel 2.6.18-rc4. I 
> cross compile the kernel for a MIPS target on a PC.
> MIPS architecture assigns CROSS_COMPILE in
> its arch/mips/Makefile but it is not included by the 
> main Makefile from the begining. So one of the
> consequence is that CC variable is not correctly
> set until arch's Makefile is included. It's set to "gcc"
> since CROSS_COMPILE is still not defined instead
> of "mips-linux-gcc". During this time CC variable is 
> used to setup CFLAGS for example.
> 
> is it something known ?
It has been reported before but thanks for the reminder.
I will try to cook up a fix tonight.

	Sam
