Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270518AbTHHIvb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 04:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270524AbTHHIvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 04:51:31 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36358 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270518AbTHHIva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 04:51:30 -0400
Date: Fri, 8 Aug 2003 09:51:26 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jochen Friedrich <jochen@scram.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, dahinds@users.sourceforge.net
Subject: Re: PCI1410 Interrupt Problems
Message-ID: <20030808095126.B32585@flint.arm.linux.org.uk>
Mail-Followup-To: Jochen Friedrich <jochen@scram.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	dahinds@users.sourceforge.net
References: <20030807000914.J16116@flint.arm.linux.org.uk> <Pine.LNX.4.44.0308080739400.6802-100000@gfrw1044.bocc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0308080739400.6802-100000@gfrw1044.bocc.de>; from jochen@scram.de on Fri, Aug 08, 2003 at 07:40:19AM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 08, 2003 at 07:40:19AM +0200, Jochen Friedrich wrote:
> Hi Russel,

Grumble.

> > I notice your lspci didn't list a subvendor / subdevice ID for your
> > cardbus bridges - can you confirm by reporting the output of:
> >
> > # setpci -s bus:slot.func 0x40.l
> 
> rt1-sp:~# setpci -s 00:11.0 0x40.l
> 00000000

Ok, so no subvendor/subdevice IDs to identify the hardware variant.
Hmm, this isn't going to be an easy one to automatically fix up.
Maybe we can pick up on the host bridge IDs - can you send me the
complete output of lspci -vv please?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

