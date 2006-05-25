Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030422AbWEYVOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030422AbWEYVOg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 17:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030423AbWEYVOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 17:14:36 -0400
Received: from dvhart.com ([64.146.134.43]:15245 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1030422AbWEYVOf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 17:14:35 -0400
Message-ID: <44761E38.7050702@mbligh.org>
Date: Thu, 25 May 2006 14:14:32 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Linus Torvalds <torvalds@osdl.org>, Kyle McMartin <kyle@mcmartin.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add compile domain
References: <20060525141714.GA31604@skunkworks.cabal.ca> <Pine.LNX.4.61.0605252027380.13379@yvahk01.tjqt.qr> <Pine.LNX.4.64.0605251146260.5623@g5.osdl.org> <200605251954.06227.s0348365@sms.ed.ac.uk> <Pine.LNX.4.61.0605252100070.13379@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0605252100070.13379@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 20:35 mason:/etc # rpm -qf `which hostname`
> net-tools-1.60-37
> 21:00 mason:/etc # hostname -v
> gethostname()=`mason'
> mason
> 21:00 mason:/etc # hostname --fqdn
> mason
> 21:00 mason:/etc # domainname
> (none)
> 21:00 mason:/etc # dnsdomainname
> 
> 
> Runs Aurora Linux 2.0.

Ubuntu does this too:

mbligh@flay:~$ hostname
flay
mbligh@flay:~$ hostname --fqdn
localhost.localdomain

