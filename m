Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWDSVE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWDSVE2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 17:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWDSVE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 17:04:28 -0400
Received: from outmx021.isp.belgacom.be ([195.238.4.202]:52943 "EHLO
	outmx021.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1751248AbWDSVE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 17:04:27 -0400
Date: Wed, 19 Apr 2006 23:04:17 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Corey Minyard <minyard@acm.org>
Cc: Rudolf Marek <r.marek@sh.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Watchdog device class
Message-ID: <20060419210417.GB4205@infomag.infomag.iguana.be>
References: <4443EED9.30603@sh.cvut.cz> <44457128.2010708@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44457128.2010708@acm.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corey,

> Some watchdog devices have the ability to say "I'm about to reboot you,
> do you want to do something about it?".  The IPMI watchdog calls this a
> pretimeout, but I have seen this concept on at least two other watchdog
> devices.  This can be delivered via an NMI or SMI and can be used to
> inform the OS ahead of time that it's going to reboot the system.  This
> is useful because you can panic, do a coredump, or perform other useful
> operations instead of just rebooting.
> 
> Do you think this interface belongs in the structure?

It definitely does and that's why I stored your patch from 1-Nov-2005
and added it to my experimental tree just now.

Greetings,
Wim.

