Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266143AbUI0GAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266143AbUI0GAa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 02:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266149AbUI0GAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 02:00:30 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36877 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266143AbUI0GA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 02:00:29 -0400
Date: Mon, 27 Sep 2004 07:00:23 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Lukas Hejtmanek <xhejtman@fi.muni.cz>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.9-rc2-mm2 pcmcia oops
Message-ID: <20040927070023.A30364@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Lukas Hejtmanek <xhejtman@fi.muni.cz>, linux-kernel@vger.kernel.org,
	Greg KH <greg@kroah.com>
References: <20040926221614.GB1466@mail.muni.cz> <20040926184327.79e05988.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040926184327.79e05988.akpm@osdl.org>; from akpm@osdl.org on Sun, Sep 26, 2004 at 06:43:27PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2004 at 06:43:27PM -0700, Andrew Morton wrote:
> Well quirk_usb_early_handoff() should be __devinit, not __init.

I thought we got all those?  I guess the recent PCI quirk cleanup
reintroduced these bugs.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
