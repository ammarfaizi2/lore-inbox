Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265504AbTFMTpQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 15:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265505AbTFMTpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 15:45:16 -0400
Received: from mail.ccur.com ([208.248.32.212]:16401 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S265504AbTFMTpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 15:45:13 -0400
Date: Fri, 13 Jun 2003 15:57:17 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paul Mackerras <paulus@samba.org>, Patrick Mochel <mochel@osdl.org>,
       Robert Love <rml@tech9.net>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@digeo.com>, sdake@mvista.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] udev enhancements to use kernel event queue
Message-ID: <20030613195717.GA26221@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <1055460564.662.339.camel@localhost> <Pine.LNX.4.44.0306121629590.11379-100000@cherise> <16105.3943.510055.309447@nanango.paulus.ozlabs.org> <1055493713.5169.10.camel@dhcp22.swansea.linux.org.uk> <16105.44765.930081.44739@cargo.ozlabs.ibm.com> <1055511099.5162.53.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055511099.5162.53.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 02:31:40PM +0100, Alan Cox wrote:
> On Gwe, 2003-06-13 at 12:00, Paul Mackerras wrote:
> > Alan Cox writes:
> > 
> > > lock xaddl $1, [foo]
> > 
> > On 386?  I stand corrected. :)
> 
> Turns out its 486 and higher, so you win. 


Perhaps it's time to remove 386 support from 2.5?  Users
of very old machines can stick with 2.0, 2.2 or 2.4.

Joe
