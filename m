Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262866AbUCJWyG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 17:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262860AbUCJWxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 17:53:51 -0500
Received: from mail.gmx.de ([213.165.64.20]:50072 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262866AbUCJWw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 17:52:58 -0500
X-Authenticated: #4512188
Message-ID: <404F9C52.5090602@gmx.de>
Date: Wed, 10 Mar 2004 23:53:06 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>
CC: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Dominik Brodowski <linux@brodo.de>
Subject: Re: ACPI PM Timer vs. C1 halt issue
References: <404E38B7.5080008@gmx.de>	 <1078870289.12084.8.camel@cog.beaverton.ibm.com>  <404E4913.3020005@gmx.de>	 <1078955372.2696.23.camel@cog.beaverton.ibm.com> <1078956711.2557.72.camel@dhcppc4>
In-Reply-To: <1078956711.2557.72.camel@dhcppc4>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That said, I don't know what caused the regression you describe. 
> Perhaps you can clarfiy the minimal changes necessary to switch between
> correct and incorrect behaviour?

Or in short word:

HOT:
Detected 2204.949 MHz processor.
Using pmtmr for high-res timesource

COOL:
Detected 2205.177 MHz processor.
Using tsc for high-res timesource


Otherwise no difference in config.

Prakash

