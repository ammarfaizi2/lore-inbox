Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbTDHI5h (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 04:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262701AbTDHI5h (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 04:57:37 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:40708 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262675AbTDHI5h (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 04:57:37 -0400
Date: Tue, 8 Apr 2003 11:09:13 +0200
From: Martin Mares <mj@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: clean up pci interrupt line whacking
Message-ID: <20030408090913.GA30469@atrey.karlin.mff.cuni.cz>
References: <200304080015.h380Fc34009018@hraefn.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304080015.h380Fc34009018@hraefn.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +				if (findev->irq != dev->irq) {
>  					findev->irq = dev->irq;
> -					pci_write_config_byte(findev,
> -						PCI_INTERRUPT_LINE, irq);
>  				}

The if seems to make no sense here :-)

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"I don't give a damn for a man that can only spell a word one way." -- M. Twain
