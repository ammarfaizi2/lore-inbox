Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbWEVOcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWEVOcV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 10:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWEVOcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 10:32:21 -0400
Received: from mail.unixshell.com ([207.210.106.37]:19360 "EHLO
	mail.unixshell.com") by vger.kernel.org with ESMTP id S1750857AbWEVOcU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 10:32:20 -0400
Message-ID: <4471CB54.401@tektonic.net>
Date: Mon, 22 May 2006 10:31:48 -0400
From: Matt Ayres <matta@tektonic.net>
Organization: TekTonic
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Patrick McHardy <kaber@trash.net>
CC: James Morris <jmorris@namei.org>,
       "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] Re: Panic in ipt_do_table with 2.6.16.13-xen
References: <4468BE70.7030802@tektonic.net> <4468D613.20309@trash.net>	<44691669.4080903@tektonic.net>	<Pine.LNX.4.64.0605152331140.10964@d.namei>	<4469D84F.8080709@tektonic.net>	<Pine.LNX.4.64.0605161127030.16379@d.namei>	<446D0A0D.5090608@tektonic.net>	<Pine.LNX.4.64.0605182002330.6528@d.namei> <446D0E6D.2080600@tektonic.net> <446D151D.6030307@tektonic.net> <4470A6CD.5010501@trash.net>
In-Reply-To: <4470A6CD.5010501@trash.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patrick McHardy wrote:
> Matt Ayres wrote:
>> I think I confirmed the NIC is not the source of the problem.  A few of
>> my servers have e100/tulip NIC's due to a bug with the chipset of the
>> on-board TG3 cards firmware and TSO.  These servers that use the
>> e100/tulip drivers also experience the ipt_do_table bug.
> 
> There is an identical report in the netfilter bugzilla, also crashes
> (on x86_64) in ipt_do_table with Xen. I haven't heard anything of
> similar crashes without Xen, so I doubt that the bug is in the
> netfilter code.
> 
> https://bugzilla.netfilter.org/bugzilla/show_bug.cgi?id=478

Yep... too coincidental.  I'd say it has _something_ to do with Xen. 
I've been doing different things on my side to try to reduce the 
severity of the problem, but I'd really like to hear what the Xen guys 
have to say about this now..

Thanks,
Matt
