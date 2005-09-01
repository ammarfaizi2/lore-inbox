Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750886AbVIAJWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbVIAJWx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 05:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbVIAJWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 05:22:53 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:64899 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750886AbVIAJWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 05:22:52 -0400
Date: Thu, 1 Sep 2005 11:22:32 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Daniel Walker <dwalker@mvista.com>
cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>, akpm@osdl.org,
       joe.korty@ccur.com, george@mvista.com, johnstul@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: RE: FW: [RFC] A more general timeout specification
In-Reply-To: <1125533289.15034.64.camel@dhcp153.mvista.com>
Message-ID: <Pine.LNX.4.61.0509011119580.3728@scrub.home>
References: <F989B1573A3A644BAB3920FBECA4D25A042B030A@orsmsx407> 
 <Pine.LNX.4.61.0509010136350.3743@scrub.home> <1125533289.15034.64.camel@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 31 Aug 2005, Daniel Walker wrote:

> > What "more versions" are you talking about? When you convert a user time 
> > to kernel time you can automatically validate it and later you can use 
> > standard kernel APIs, so you don't have to add even more API bloat.
> 
> What's kernel time? Are you talking about jiffies? The whole point of
> multiple clocks is to allow for different degrees of precision. 

For a timeout? Please get real.
If you need more precision, use a dedicated timer API, but don't make the 
general case more complex for the 99.99% of other users.

bye, Roman
