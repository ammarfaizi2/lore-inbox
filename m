Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030324AbWHRRVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbWHRRVY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 13:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbWHRRVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 13:21:24 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:22739 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030324AbWHRRVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 13:21:24 -0400
Date: Fri, 18 Aug 2006 19:21:09 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andi Kleen <ak@suse.de>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [patch 2/5] -fstack-protector feature: Add the Kconfig option
Message-ID: <20060818172109.GB7595@mars.ravnborg.org>
References: <1155746902.3023.63.camel@laptopd505.fenrus.org> <200608181308.07752.ak@suse.de> <1155900206.4494.141.camel@laptopd505.fenrus.org> <200608181605.19520.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608181605.19520.ak@suse.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 04:05:19PM +0200, Andi Kleen wrote:
> 
> > the binary search argument in this case is moot, just having a config
> > option doesn't break anything compile wise and each later step is
> > self-compiling..
> 
> Not true when the config used for the binary search has stack protector
> enabled.
kconfig will remove undefined CONFIG_ options from the .config as part
of the kernel compile.

	Sam
