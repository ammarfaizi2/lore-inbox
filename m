Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264920AbUAERfL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 12:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265216AbUAERfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 12:35:11 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58380 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264920AbUAERfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 12:35:04 -0500
Date: Mon, 5 Jan 2004 17:34:59 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mouse info in 2.6.1-rc1
Message-ID: <20040105173459.B11207@flint.arm.linux.org.uk>
Mail-Followup-To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0401051716590.23750@student.dei.uc.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0401051716590.23750@student.dei.uc.pt>; from marado@student.dei.uc.pt on Mon, Jan 05, 2004 at 05:25:41PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 05:25:41PM +0000, Marcos D. Marado Torres wrote:
> Hi there...
> I don't really know if this is only in -rc1-mm1 but I suppose -rc1 is affected also.
> 
> The new changes about synaptics (I think that it was it) made that we don't have
> anymore a boolean (selectable) option in Device Drivers -> Input Device Support
> -> Mouse Interface;
> Although, it we so to the "non-selectable" option Mouse Interface, the help info
> exists and talks about "slect it if...", so...

Look closer, particularly at this bit:

        tristate "Mouse interface" if EMBEDDED
                                   ^^^^^^^^^^^

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
