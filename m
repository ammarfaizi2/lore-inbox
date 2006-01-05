Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbWAEPWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWAEPWu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 10:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWAEPWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 10:22:49 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:60581 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751417AbWAEPWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 10:22:49 -0500
Date: Thu, 5 Jan 2006 11:14:36 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/9] UML - Better diagnostics for broken configs
Message-ID: <20060105161436.GA4426@ccure.user-mode-linux.org>
References: <200601042151.k04LpxbH009237@ccure.user-mode-linux.org> <Pine.LNX.4.61.0601050844550.10161@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601050844550.10161@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 08:45:36AM +0100, Jan Engelhardt wrote:
> >Produce a compile-time error if both MODE_SKAS and MODE_TT are disabled.
>
> What would happen if both were disabled?
> Say, if the host system does not have SKAS and I did not want any 
> tracing/debugging stuff?

You get a UML that can't run.  TT mode isn't tracing/debugging stuff.  It's 
a basic mode of UML operation.  Also, UML doesn't need the skas patch on
the host in order to use skas mode any more.  It helps, but is not necessary.

				Jeff
