Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266173AbUAQUh2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 15:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266175AbUAQUh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 15:37:28 -0500
Received: from dci.doncaster.on.ca ([66.11.168.194]:20437 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S266173AbUAQUh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 15:37:26 -0500
To: mljf@altern.org
Cc: Greg Stark <gsstark@mit.edu>, Maciej Soltysiak <solt@dns.toxicfilms.tv>,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: No mouse wheel under 2.6.1 [Was: Re: Where are 2.6.x upgrade notes?]
References: <87ptdocmf1.fsf@stark.xeocode.com>
	<003801c3d9c4$2c2dead0$0e25fe0a@southpark.ae.poznan.pl>
	<873caj0y96.fsf_-_@stark.xeocode.com> <1074352816.3838.2.camel@sid>
In-Reply-To: <1074352816.3838.2.camel@sid>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 17 Jan 2004 15:37:25 -0500
Message-ID: <87fzee1fcq.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Joaquim Fellmann <mljf@altern.org> writes:

> I had the same problem. Switching protocol from MousemanPlusPS/2 to
> ImPS2 in XF86Config-4 fixed it.

One Mr Pavlik solved the same issue on bugzilla:

    ------- Additional Comment #1 From Vojtech Pavlik 2004-01-14 09:35 ------- 
    Use protocol "ExplorerPS/2" in XFree86. This may not seem logical, but
    because 2.6 handles the Logitech mouse protocol itself and presents a more
    common Microsoft-like protocol to applications that don't know how to use
    its native event protocol.

I wonder how the IM and Explorer protocols relate.

-- 
greg

