Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264746AbUD3QAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264746AbUD3QAE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 12:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265096AbUD3QAD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 12:00:03 -0400
Received: from [195.23.16.24] ([195.23.16.24]:11992 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S264746AbUD3P7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 11:59:41 -0400
Message-ID: <40927769.3020100@grupopie.com>
Date: Fri, 30 Apr 2004 16:57:29 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: GrupoPIE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Marc Boucher <marc@linuxant.com>
Cc: Rik van Riel <riel@redhat.com>, Timothy Miller <miller@techsource.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <Pine.LNX.4.44.0404281958310.19633-100000@chimarrao.boston.redhat.com> <4150E18A-9985-11D8-85DF-000A95BCAC26@linuxant.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.25.0.3; VDF: 6.25.0.40; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Boucher wrote:

> 
> Hi Rik,
> 
> Your new proposed message sounds much clearer to the ordinary mortal and 
> would imho be a significant improvement. Perhaps printing repetitive 
> warnings for identical $MODULE_VENDOR strings could also be avoided, 
> taking care of the redundancy/volume problem as well..

I'm one of the first persons who posted to this thread, and I'm starting to 
regret that I did.

I believe Marc did the GPL\0 trick just to avoid the warnings. It was wrong to 
do it and he already apologised.

IMHO writing a more descriptive message and not issuing the tainting warning 
more than once *at all*, seems pretty harmless and would solve problems for 
everyone and we could just move on with our lifes (this thread has almost 150 
posts now!)

The only problem with reporting only once would be to have remove one module at 
a time and rebooting until untainting. In my opinion, if your system is so out 
of control that you don't know what modules are tainting it, you deserve to have 
make 3 reboots to remove 3 modules :)

Some people feel that Linuxant isn't helping the comunnity because hardware 
manufacturers won't feel obligated to release open source drivers if thay have a 
closed source alternative.

IMHO what makes manufacturers care about Linux is market share. Until we have a 
fair market share, manufacturers won't bother developing for Linux, because 
their return on this effort will be minimal.

Linuxant is in fact helping Linux geting a bigger market share.

Anyway, as everyone on this list I strongly prefer open-source drivers. Users 
prefer open-source drivers, specially if they already come with their 
distribution and just work out-of-the-box.

So if the hardware manufacturers start caring about linux (because of the 
increased market share), they will release open source drivers. Just look at the 
manufacturers that produce hardware for high-end servers (where the Linux market 
share is already very high). Network cards, RAID controllers, etc., already have 
open source drivers, because of this.

Linux is taking over, it is just a matter of time now :)

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"


