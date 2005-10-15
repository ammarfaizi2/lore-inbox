Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbVJOTkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbVJOTkw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 15:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbVJOTkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 15:40:52 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:51642 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751120AbVJOTkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 15:40:51 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43515ADA.6050102@s5r6.in-berlin.de>
Date: Sat, 15 Oct 2005 21:39:06 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux1394-devel@lists.sourceforge.net
CC: jbarnes@virtuousgeek.org, linux-kernel@vger.kernel.org
Subject: Re: ohci1394 unhandled interrupts bug in 2.6.14-rc2
References: <20051015185502.GA9940@plato.virtuousgeek.org>
In-Reply-To: <20051015185502.GA9940@plato.virtuousgeek.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-1.472) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jbarnes@virtuousgeek.org wrote:
> I've been experiencing a bug in the Fedora kernels for awhile involving
> the ohci1394 driver.  If I include the driver in my initrd (causing it
> to be loaded at boot time), the IRQ corresponding to my TI OHCI firewire
> controller is disabled
...
> this is a Toshiba Satellite laptop)

Somebody mentioned this Linux-on-Toshiba-Satellite page recently on 
linux1394-user: http://www.janerob.com/rob/ts5100/index.shtml
The patch available from there was briefly discussed in February:
http://marc.theaimsgroup.com/?l=linux1394-devel&t=110786507900006

Does this patch correct the problem on your machine?
-- 
Stefan Richter
-=====-=-=-= =-=- -====
http://arcgraph.de/sr/
