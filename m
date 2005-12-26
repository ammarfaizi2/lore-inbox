Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbVLZURz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbVLZURz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 15:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbVLZURz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 15:17:55 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49425 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932133AbVLZURy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 15:17:54 -0500
Date: Mon, 26 Dec 2005 20:17:37 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][MMC] Buggy cards need to leave programming state
Message-ID: <20051226201737.GB17191@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	LKML <linux-kernel@vger.kernel.org>
References: <43AFEDF8.2060404@drzeus.cx> <20051226191307.GA17191@flint.arm.linux.org.uk> <43B04B43.5080705@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43B04B43.5080705@drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2005 at 08:57:55PM +0100, Pierre Ossman wrote:
> Russell King wrote:
> > whereas it's impossible to tell with the November dump because
> > the useful information has been edited out.  Hence the November
> > dump is rather useless.
> 
> What seems to be missing?

The lines containing the respose to the CMD0x18 and CMD0x0d - iow
the card status.  I'd like to see the result from the previous
two commands to the errors occurring.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
