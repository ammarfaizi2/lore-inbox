Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264932AbUELKWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264932AbUELKWv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 06:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264938AbUELKWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 06:22:51 -0400
Received: from adsl-static-1-36.uklinux.net ([62.245.36.36]:34776 "EHLO
	bristolreccc.co.uk") by vger.kernel.org with ESMTP id S264932AbUELKWs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 06:22:48 -0400
Subject: Re: problem with sis900 driver 2.6.5 +
From: mike <mike@bristolreccc.co.uk>
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040512005008.GA18347@cathedrallabs.org>
References: <1084300104.24569.8.camel@datacontrol>
	 <20040512005008.GA18347@cathedrallabs.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 12 May 2004 11:19:06 +0100
Message-Id: <1084357146.24569.13.camel@datacontrol>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.7 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-11 at 21:50 -0300, Aristeu Sergio Rozanski Filho wrote:
> > In kernels 2.6.5 and above (may affect 2.6.4 as well) there seems to be
> > a problem with the sis900 eth driver
> > 
> > I have a sis chipset with integrated ethernet sis900 driver which has
> > always worked perfectly up to and including 2.6.3 (fedora)
> > 
> > Now with both fedora 2.6.5 kernel and vanilla 2.6.6 eth0 does not come
> > up
> > 
> > relevant messages
> > 
> > sis900 device eth0 does not appear to be present delaying initialisation
> > 
> > and from dmesg eth0: cannot find ISA bridge
> > 
> > 2.6.3 works fine
> > 
> > lsmod shows sis and sis900 modules loaded fine
> I had the same problem, the patch attached is a dirty fix to get it
> running again. in newer kernels its isa bridge is listed with a different
> product id (0x0018). no idea why.
> 

this works fine - thanks

> -- 
> Aristeu
> 
