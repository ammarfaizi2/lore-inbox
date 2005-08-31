Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932528AbVHaTxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbVHaTxi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 15:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbVHaTxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 15:53:38 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43793 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932528AbVHaTxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 15:53:37 -0400
Date: Wed, 31 Aug 2005 20:53:19 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Mark Lord <mlord@pobox.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: APs from the Kernel Summit run Linux
Message-ID: <20050831205319.A6385@flint.arm.linux.org.uk>
Mail-Followup-To: Mark Lord <mlord@pobox.com>,
	Vojtech Pavlik <vojtech@suse.cz>,
	LKML <linux-kernel@vger.kernel.org>
References: <20050830093715.GA9781@midnight.suse.cz> <4315E0F0.6060209@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4315E0F0.6060209@pobox.com>; from mlord@pobox.com on Wed, Aug 31, 2005 at 12:55:12PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2005 at 12:55:12PM -0400, Mark Lord wrote:
> I'll try loading the works into another ARM
> system I have here, and see (1) if it runs as-is,
> and (2) what the disassembly shows.

You can identify ARM code quite readily - look for a large number of
32-bit words naturally aligned and grouped together whose top nibble
is 14 - ie 0xE.......

The top nibble is the conditional execution field, and 14 is "always".

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
