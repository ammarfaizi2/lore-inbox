Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbTKCLU5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 06:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbTKCLU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 06:20:56 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26639 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261793AbTKCLUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 06:20:55 -0500
Date: Mon, 3 Nov 2003 11:20:50 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Martin Zwickel <martin.zwickel@technotrend.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel floating point emulation for big endian arm?
Message-ID: <20031103112050.A23136@flint.arm.linux.org.uk>
Mail-Followup-To: Martin Zwickel <martin.zwickel@technotrend.de>,
	linux-kernel@vger.kernel.org
References: <20031103115134.63262f54.martin.zwickel@technotrend.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031103115134.63262f54.martin.zwickel@technotrend.de>; from martin.zwickel@technotrend.de on Mon, Nov 03, 2003 at 11:51:34AM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 03, 2003 at 11:51:34AM +0100, Martin Zwickel wrote:
> Hi there!
> 
> Is there a working version of kernel floating point emulation for big endian
> arm?
> 
> The version I currently use is 2.4.21-pre5 and fp emu doesn't work
> correctly I think.

nwfpe is correctly implemented for big endian.  Most likely is that
your library doesn't know how to crrectly handle the ARM floating
point implementation.

You might also consider taking this to the linux-arm mailing list
at lists.arm.linux.org.uk.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
