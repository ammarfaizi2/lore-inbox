Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267163AbSLKNso>; Wed, 11 Dec 2002 08:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267164AbSLKNso>; Wed, 11 Dec 2002 08:48:44 -0500
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:34833 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S267163AbSLKNsn>;
	Wed, 11 Dec 2002 08:48:43 -0500
Message-ID: <3DF74436.80807@mvista.com>
Date: Wed, 11 Dec 2002 07:57:10 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vamsi@in.ibm.com
CC: Stephen Hemminger <shemminger@osdl.org>,
       Kernel List <linux-kernel@vger.kernel.org>,
       lkcd-devel@lists.sourceforge.net, ak@suse.de, vamsi_krishna@in.ibm.com
Subject: Re: [PATCH] Notifier for significant events on i386
References: <1039471369.1055.161.camel@dell_ss3.pdx.osdl.net> <20021211165153.A17546@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vamsi Krishna S . wrote:

>Andi,
>
>Isn't this a problem on x86_64 too? What is there to prevent a
>handler from being removed from the notifier list while it
>is being used to call the handler on another CPU?
>
>I am considering using a RCU-based list for notifier chains.
>Corey has done some work on these lines to add NMI notifier
>chain, I think it should be generalised on for all notifiers.
>
>Thoughts? Comments?
>  
>
This is probably a good idea.  I won't be able to work on it for a 
while, but you can grab
my patch at http://sourceforge.net/projects/openipmi/, look under the 
2.5 releases for
the most current linux-nmi-2.5.xx-vyy.diff.

-Corey


