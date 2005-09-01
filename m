Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbVIAPs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbVIAPs2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 11:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbVIAPs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 11:48:28 -0400
Received: from users.ccur.com ([208.248.32.211]:163 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S1030212AbVIAPs1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 11:48:27 -0400
Date: Thu, 1 Sep 2005 11:47:53 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>, akpm@osdl.org,
       george@mvista.com, johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: FW: [RFC] A more general timeout specification
Message-ID: <20050901154753.GA3433@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <F989B1573A3A644BAB3920FBECA4D25A042B030A@orsmsx407> <Pine.LNX.4.61.0509010136350.3743@scrub.home> <20050901135049.GB1753@tsunami.ccur.com> <Pine.LNX.4.61.0509011610570.3743@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0509011610570.3743@scrub.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 04:32:49PM +0200, Roman Zippel wrote:
> On Thu, 1 Sep 2005, Joe Korty wrote:

> > Kernel time sucks.  It is just a single clock, it may not have
> > the attributes of the clock that the user really wished to use.
> 
> Wrong. The kernel time is simple and effective for almost all users.
> We are talking about _timeouts_ here, what fancy "attributes" does that 
> need that are just not overkill?

The name should be changed from 'struct timeout' to something like
'struct timeevent'.

Joe
