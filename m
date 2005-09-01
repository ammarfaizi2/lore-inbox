Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965135AbVIANyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965135AbVIANyF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 09:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965134AbVIANyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 09:54:03 -0400
Received: from users.ccur.com ([208.248.32.211]:40382 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S965118AbVIANyA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 09:54:00 -0400
Date: Thu, 1 Sep 2005 09:53:11 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Daniel Walker <dwalker@mvista.com>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>, akpm@osdl.org,
       george@mvista.com, johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: FW: [RFC] A more general timeout specification
Message-ID: <20050901135311.GC1753@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <F989B1573A3A644BAB3920FBECA4D25A042B030A@orsmsx407> <Pine.LNX.4.61.0509010136350.3743@scrub.home> <1125533289.15034.64.camel@dhcp153.mvista.com> <Pine.LNX.4.61.0509011119580.3728@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0509011119580.3728@scrub.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 11:22:32AM +0200, Roman Zippel wrote:
> For a timeout? Please get real.
> If you need more precision, use a dedicated timer API, but don't make the 
> general case more complex for the 99.99% of other users.

Struct timeout is just a struct timespec + a bit for absolute/relative +
a field for clock specification.  What's so complex about that?  It captures
everything needed to specify time, from here to the end of time.

Joe
