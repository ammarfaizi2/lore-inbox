Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267237AbUBROHh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 09:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267286AbUBROHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 09:07:37 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:27627 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S267273AbUBROHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 09:07:35 -0500
Date: Wed, 18 Feb 2004 08:53:00 -0500
From: Ben Collins <bcollins@debian.org>
To: Alexey Goldin <ab_goldin@swissmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Firewire troubles with  SMP kernel
Message-ID: <20040218135300.GN957@phunnypharm.org>
References: <1075940005.11793.34.camel@hobbit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075940005.11793.34.camel@hobbit>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 04:13:26PM -0800, Alexey Goldin wrote:
> Thanks to fine people who helped me to sort out problems with my laptop
> couple of months ago. This is the timeto ask for help again :-)
> 
> Please cc: any reply to me as I am not subscribed to the list. 
> 
> Well, I know firewire with SMP is a little bit iffy. 
> However we managed to get it working on one computer and we hoped it
> will work with other. Here is what we have instead.
> 
> The first computer is dual Athlon-MP with Tyan mobo, firewire card is 
> fairly basic, we got it from
> http://shop.store.yahoo.com/gooddealpc-store/139pci3p.html 
> We tried it with Western Digital 120GB firewire drives and with IDE
> enclosures:

I'm running firewire with SMP kernels with no problems. I think the
issue is you are using old drivers that may not be working with SMP. Try
build the latest drivers from linux1394.org for 2.4.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
