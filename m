Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274857AbTHKWUc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 18:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274859AbTHKWUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 18:20:32 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37125 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S274857AbTHKWUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 18:20:24 -0400
Date: Mon, 11 Aug 2003 23:20:19 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add an -Os config option
Message-ID: <20030811232019.A28700@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	linux-kernel@vger.kernel.org
References: <20030811211145.GA569@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030811211145.GA569@fs.tum.de>; from bunk@fs.tum.de on Mon, Aug 11, 2003 at 11:11:45PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 11:11:45PM +0200, Adrian Bunk wrote:
> The patch below adds an option OPTIMIZE_FOR_SIZE (depending on EMBEDDED) 
> that changes the optimization from -O2 to -Os.

What about those of us who already build the kernel with -Os (eg, ARM) ?

This option will be confusing in that situation.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

