Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTG1MXA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 08:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263738AbTG1MXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 08:23:00 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:62983 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263637AbTG1MW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 08:22:59 -0400
Date: Mon, 28 Jul 2003 13:38:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
Subject: Re: PATCH: keyboard controller by default if not embedded
Message-ID: <20030728133813.A2520@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	torvalds@osdl.org
References: <200307272004.h6RK49Ae029610@hraefn.swansea.linux.org.uk> <20030728081545.C1707@infradead.org> <1059392089.15438.20.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1059392089.15438.20.camel@dhcp22.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Mon, Jul 28, 2003 at 12:34:50PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 12:34:50PM +0100, Alan Cox wrote:
> On Llu, 2003-07-28 at 08:15, Christoph Hellwig wrote:
> > Again this is crap and make no sense for most x86 subarches except
> > X86_PC.  And means useless bloat for all my modwern PeeCees with USB
> > keyboard and mouse.
> 
> USB isnt the default yet and it stops a zillion people reporting 2.6.0-test
> doesn't work or hangs on boot as they are now. 

Have you seen the CONFIG_VT implies CONFIG_INPUT patch?  Makes a
whole lot more sense and doesn't force people to bloat their kernels.

