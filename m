Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbTIWOBB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 10:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbTIWOBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 10:01:01 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45323 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263375AbTIWOBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 10:01:00 -0400
Date: Tue, 23 Sep 2003 15:00:55 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Daniel Luebke <lkml@daniel-luebke.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: System Freeze with Kernel 2.6.0-test5 and PCMCIA 3Com
Message-ID: <20030923150055.H1299@flint.arm.linux.org.uk>
Mail-Followup-To: Daniel Luebke <lkml@daniel-luebke.de>,
	linux-kernel@vger.kernel.org
References: <3F704FAF.8050000@daniel-luebke.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F704FAF.8050000@daniel-luebke.de>; from lkml@daniel-luebke.de on Tue, Sep 23, 2003 at 03:50:39PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 03:50:39PM +0200, Daniel Luebke wrote:
> However, when using 2.6.0-test5 and inserting a PCMCIA card, namely a 
> 3COM NIC (3CSH572BT, whoever invents such model names...), my system 
> freezes without kernel oops (no flashing lights etc.) but only printing 
> the line

Known problem - please apply the patch found in the following message
(which you can find by searching lkml):

Date:   Sat, 20 Sep 2003 22:22:07 +0100
From:   Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PCMCIA]  Xircom nic hang on boot since cs.c race condition patch

Thanks.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
      Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
      maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                      2.6 Serial core
