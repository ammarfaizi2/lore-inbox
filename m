Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264592AbUDVRWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264592AbUDVRWm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 13:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264599AbUDVRWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 13:22:42 -0400
Received: from fmr99.intel.com ([192.55.52.32]:20447 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S264592AbUDVRWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 13:22:37 -0400
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
	for idle=C1halt, 2.6.5
From: Len Brown <len.brown@intel.com>
To: Jesse Allen <the3dfxdude@hotmail.com>
Cc: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       Craig Bradney <cbradney@zip.com.au>, ross@datscreative.com.au,
       christian.kroener@tu-harburg.de, linux-kernel@vger.kernel.org,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>, a.verweij@student.tudelft.nl,
       Allen Martin <AMartin@nvidia.com>
In-Reply-To: <20040422163958.GA1567@tesore.local>
References: <200404131117.31306.ross@datscreative.com.au>
	 <200404131703.09572.ross@datscreative.com.au>
	 <1081893978.2251.653.camel@dhcppc4>
	 <200404160110.37573.ross@datscreative.com.au>
	 <1082060255.24425.180.camel@dhcppc4>
	 <1082063090.4814.20.camel@amilo.bradney.info>
	 <1082578957.16334.13.camel@dhcppc4> <4086E76E.3010608@gmx.de>
	 <1082587298.16336.138.camel@dhcppc4>  <20040422163958.GA1567@tesore.local>
Content-Type: text/plain
Organization: 
Message-Id: <1082654469.16333.351.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 22 Apr 2004 13:21:09 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-22 at 12:39, Jesse Allen wrote:

> On the Shuttle AN35N, the C1 disconnect option default is auto.  If you're
> talking about this board, or another board Shuttle seemingly fixed, then I
> can tell you that I haven't been able to get my to hang with vanilla kernels.

Have you been able to hang the AN35N under any conditions?
Old BIOS, non-vanilla kernel?

> As for your patch, I get a fast timer, and gain about 1 sec per 5 minutes.
> The only patch that seemed to work without a fast timer so far was the one 
> removed by Linus in a testing version.  The AN35N has the timer override 
> bug.

Hmm, I didn't notice fast time on my FN41, i'll look for it.

I'm not familiar with the "one removed by Linux in a testing version",
perhaps you could point me to that?

> Attached is the dmidecode for the AN35N.

applied.

thanks,
-Len


