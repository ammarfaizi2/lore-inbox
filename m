Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936131AbWLAKkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936131AbWLAKkj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 05:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936187AbWLAKkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 05:40:39 -0500
Received: from isilmar.linta.de ([213.239.214.66]:50304 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S936131AbWLAKki (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 05:40:38 -0500
Date: Fri, 1 Dec 2006 05:40:37 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Linda Walsh <lkml@tlinx.org>
Cc: Srinivasa Ds <srinivasa@in.ibm.com>, john stultz <johnstul@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: PM-Timer clock source is slow. Try something else: How slow? What other source(s)?
Message-ID: <20061201104037.GA15645@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Linda Walsh <lkml@tlinx.org>, Srinivasa Ds <srinivasa@in.ibm.com>,
	john stultz <johnstul@us.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <456E2C2C.40303@tlinx.org> <1164850329.5426.33.camel@localhost.localdomain> <456E8181.4060109@in.ibm.com> <456F3378.5030708@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <456F3378.5030708@tlinx.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2006 at 11:39:36AM -0800, Linda Walsh wrote:
> Srinivasa Ds wrote: 
> >You can change the clock source using "clock=" kernel parameter. 
> >Please refer to  Documentation/kernel-parameters.txt file of kernel 
> >source.
> ---
>    Uh, yeah...you mean the "clock=" parameter that is
>  "deprecated"    ?   :-)
> 
>    *cough*
>    *sigh*

"clocksource=" is the replacement.

	Dominik
