Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751609AbWAIWyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbWAIWyz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 17:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbWAIWyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 17:54:55 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64529 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751253AbWAIWyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 17:54:55 -0500
Date: Mon, 9 Jan 2006 22:54:49 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus@drzeus.cx>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Indicate that R1/R1b contains command opcode
Message-ID: <20060109225449.GI19131@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus@drzeus.cx>,
	Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org
References: <20060106183802.10810.81449.stgit@poseidon.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106183802.10810.81449.stgit@poseidon.drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 07:38:03PM +0100, Pierre Ossman wrote:
> Some controllers actually check the first byte of the response (most don't).
> This byte contains the command opcode for R1/R1b and all 1:s for other types.
> The difference must be indicated to the controller so it knows which reply
> to expect.

Applied, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
