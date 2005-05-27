Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262530AbVE0Rpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbVE0Rpo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 13:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262529AbVE0Rpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 13:45:38 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:42330 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S262534AbVE0Ro7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 13:44:59 -0400
Date: Fri, 27 May 2005 10:44:58 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, Dave Jones <davej@codemonkey.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Message-ID: <20050527174458.GA28455@hexapodia.org>
References: <20050323184919.GA23486@hexapodia.org> <20050525171825.51a06908.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050525171825.51a06908.akpm@osdl.org>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2005 at 05:18:25PM -0700, Andrew Morton wrote:
> Andy Isaacson <adi@hexapodia.org> wrote:
> > I was previously running 2.6.11-rc3 and swsusp was working quite nicely:
> > echo shutdown > /sys/power/disk
> > echo disk > /sys/power/state
> > 
> > Now I've upgraded to 2.6.12-rc1, 423b66b6oJOGN68OhmSrBFxxLOtIEA, and it
> > no longer works reliably.  Almost every time I do the above it blocks in
> > device_resume() (I haven't had time to track it deeper than that).
> 
> Andy, can you please retest 2.6.12-rc5 and if these problems remain,
> generate new reports at bugme.osdl.org?

After two quick tests, it appears to be fixed in 2.6.12-rc5.  Thanks for
the follow-up.

-andy
