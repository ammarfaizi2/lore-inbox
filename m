Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVACAEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVACAEX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 19:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbVACAEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 19:04:23 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:53179 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261347AbVACAES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 19:04:18 -0500
Date: Mon, 3 Jan 2005 01:04:17 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andreas Schwab <schwab@suse.de>
Cc: Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@osdl.org>,
       Linux-VServer <vserver@list.linux-vserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Vserver] Re: The Future of Linux Capabilities ...
Message-ID: <20050103000417.GA31967@mail.13thfloor.at>
Mail-Followup-To: Andreas Schwab <schwab@suse.de>,
	Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@osdl.org>,
	Linux-VServer <vserver@list.linux-vserver.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20041227014041.GA30550@mail.13thfloor.at> <20041227193637.GH1043@openzaurus.ucw.cz> <jevfafy5uk.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jevfafy5uk.fsf@sykes.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2005 at 08:43:31PM +0100, Andreas Schwab wrote:
> Pavel Machek <pavel@ucw.cz> writes:
> 
> > 1) seems acceptable, as long as 64bits is enough.
> 
> That cries for an extensible interface.

I guess using an array (with at compile time fixed size)
of __u32 (or maybe __u64 on 64bit archs) would be a good
solution to make it 'compatible' with the current interface
(for the lower 32 bit) and allow to use an interface which
can handle arbitrary sizes for the 'new' syscall interface

best,
Herbert

> Andreas.
> 
> -- 
> Andreas Schwab, SuSE Labs, schwab@suse.de
> SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
> Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
> "And now for something completely different."
> _______________________________________________
> Vserver mailing list
> Vserver@list.linux-vserver.org
> http://list.linux-vserver.org/mailman/listinfo/vserver
