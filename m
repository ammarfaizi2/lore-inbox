Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264729AbUD1L02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264729AbUD1L02 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 07:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264735AbUD1L02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 07:26:28 -0400
Received: from mail.gmx.de ([213.165.64.20]:17846 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264729AbUD1L01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 07:26:27 -0400
X-Authenticated: #4512188
Message-ID: <408F94DB.5040007@gmx.de>
Date: Wed, 28 Apr 2004 13:26:19 +0200
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040413)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: ross@datscreative.com.au, Len Brown <len.brown@intel.com>,
       Jesse Allen <the3dfxdude@hotmail.com>,
       Craig Bradney <cbradney@zip.com.au>, christian.kroener@tu-harburg.de,
       linux-kernel@vger.kernel.org, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>, a.verweij@student.tudelft.nl,
       Allen Martin <AMartin@nvidia.com>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
 for idle=C1halt, 2.6.5
References: <200404131117.31306.ross@datscreative.com.au> <20040422163958.GA1567@tesore.local> <1082654469.16333.351.camel@dhcppc4> <200404262141.24616.ross@datscreative.com.au> <408ED126.4030608@gmx.de>
In-Reply-To: <408ED126.4030608@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash K. Cheemplavam wrote:
> Hi all,
> 
> I have just made soem interesting experience. It seems Len's timer 
> routing patch (or whatever you wanna call it) stabilizes my system to a 
> certain amount or NOT using AGP stabilizes it to an amount...

[snip]

Btw, I found another possible reason for this behaviour, which would fit 
into the idle temp problem I am experiencing again with 2.6.6-rc2-mm1 
kernel (unless it seems I use Ross C1halt idle patch): Perhaps this 
kernel uses the disconnect feature less often, so the probality of 
lock-up goes down. That would explain my higher temps...

Prakash
