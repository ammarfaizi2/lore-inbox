Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265211AbSLMSSw>; Fri, 13 Dec 2002 13:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265230AbSLMSSw>; Fri, 13 Dec 2002 13:18:52 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51723 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265211AbSLMSSv>; Fri, 13 Dec 2002 13:18:51 -0500
Date: Fri, 13 Dec 2002 18:26:37 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH 2.4.21-BK] Fix typo in arch/arm/config.in
Message-ID: <20021213182637.D6567@flint.arm.linux.org.uk>
Mail-Followup-To: Marc-Christian Petersen <m.c.p@wolk-project.de>,
	linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <200212131844.45280.m.c.p@wolk-project.de> <200212131859.16039.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200212131859.16039.m.c.p@wolk-project.de>; from m.c.p@wolk-project.de on Fri, Dec 13, 2002 at 06:59:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2002 at 06:59:16PM +0100, Marc-Christian Petersen wrote:
> if [ "$CONFIG_ARCH_CLPS711X" = "y" ]; then 
>    source drivers/ssi/Config.in 
> fi
> 
> drivers/ssi/Config.in does not exist, make menuconfig crashes.
> I thought it is a typo, but source'ing it twice also crashes, for sure.
> 
> So what is drivers/ssi/* ?

Its something that isn't merged, and something that I lost access to the
hardware to complete, so it isn't likely to be merged.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

