Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261961AbUJYP2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbUJYP2N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 11:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbUJYP2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:28:09 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:28165 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261962AbUJYP0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:26:50 -0400
Message-ID: <417D1E38.90007@techsource.com>
Date: Mon, 25 Oct 2004 11:39:36 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: Jan Knutar <jk-lkml@sci.fi>, Stephen Wille Padnos <spadnos@sover.net>,
       Jon Smirl <jonsmirl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
References: <4176E08B.2050706@techsource.com> <4177DF15.8010007@techsource.com> <4177E50F.9030702@sover.net> <200410220238.13071.jk-lkml@sci.fi> <41793C94.3050909@techsource.com> <20041024104038.GA12665@hh.idb.hist.no>
In-Reply-To: <20041024104038.GA12665@hh.idb.hist.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Helge Hafting wrote:
> On Fri, Oct 22, 2004 at 01:00:04PM -0400, Timothy Miller wrote:
> 
>>
>>
>>For this graphics design, and I'm getting into premature implementation 
>>details, but I'm a geek, so I can't help myself... I think having some 
>>sort of primitive microcontroller at the front end of the design is 
>>necessary.  Two major things it would do would be to control the DMA bus 
>>mastering, and translate commands (both DMA and PIO) into the parameters 
>>required by the rendering engine.
>>
> 
> 
> Perhaps a cheap general purpose cpu (last year's duron or celeron)
> could be used for this in order to save cost?  You could sell the
> cheapest version of the card with an empty socket, because so many
> people have such a processor lying around after the last upgrade.


No.

(1) Too expensive
(2) Too complicated
(3) Not good at what we need it to be good at.


No... I'm working on an idea of a CPU which is optimized specifically 
for what we need, nothing more.  AND it must fit inside the FPGA.

Tight fit.

