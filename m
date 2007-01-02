Return-Path: <linux-kernel-owner+w=401wt.eu-S964917AbXABScM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbXABScM (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 13:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbXABScL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 13:32:11 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:36930
	"EHLO gw.microgate.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964919AbXABScK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 13:32:10 -0500
X-Greylist: delayed 1180 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jan 2007 13:32:10 EST
Message-ID: <459AA49E.6030005@microgate.com>
Date: Tue, 02 Jan 2007 12:29:50 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Paul Fulghum <paulkf@microgate.com>
CC: Hollis Blanchard <hollisb@us.ibm.com>, Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       p.hardwick@option.com
Subject: Re: tty->low_latency + irq context
References: <45906820.10805@gmail.com>  <1167758231.5616.22.camel@basalt> <1167761531.3837.13.camel@amdx2.microgate.com>
In-Reply-To: <1167761531.3837.13.camel@amdx2.microgate.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum wrote:
> With low_latency == 1, flush_to_ldisc() is deferred
> until the ISR is complete and the internal spinlock is released.

Oops, I meant low_latency == 0 of course.

-- 
Paul Fulghum
Microgate Systems, Ltd.
