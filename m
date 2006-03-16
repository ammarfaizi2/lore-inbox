Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932694AbWCPSbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932694AbWCPSbe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 13:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932706AbWCPSbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 13:31:34 -0500
Received: from pproxy.gmail.com ([64.233.166.183]:6734 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932694AbWCPSbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 13:31:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=h9RSVcMOcDG4D86mvEPEexY5KNmsCOjgu6I28YC4ESZX6GC35fAroVnpSxEdsmXe/JW5oR0/rszgg4BOmF4eYGZ+Mz5gu4e+MOFTZ62r2trnT4ptx84gWx5x4hfEYOrMs/8wgaIBCt8359r1m2sgIdYbYe7Tt69OAR4Gf5x2bpM=
Message-ID: <4419AEEA.50702@gmail.com>
Date: Fri, 17 Mar 2006 03:31:06 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Nick Piggin <nickpiggin@yahoo.com.au>,
       Petr Vandrovec <petr@vandrovec.name>, linux-kernel@vger.kernel.org,
       sam@ravenborg.org, kai@germaschewski.name
Subject: Re: [PATCH] Do not rebuild full kernel tree again and again...
References: <20060312172511.GA17936@vana.vc.cvut.cz> <20060312174250.GA1470@mars.ravnborg.org> <44150CD7.604@yahoo.com.au> <20060313091254.GA28231@mars.ravnborg.org> <44154DAC.6050006@yahoo.com.au> <20060313163041.GA29719@mars.ravnborg.org>
In-Reply-To: <20060313163041.GA29719@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Mon, Mar 13, 2006 at 09:47:08PM +1100, Nick Piggin wrote:
>  >>I'm seeing this behaviour too in -rc6 and it is a bad regression
> 
>>>>for a developer. I assume there will be some workaround?
>>>
>>>I assume debian soon will update make to current version from CVS that
>>>has this behaviour removed.
>>>
>>
>>So long as it just requires a tools update then that's fine for me.
> 
> I should note here that it was agreed with Paul that upcoming make
> relase will not have this change, but next release will have it.
> So 2.6.17 kbuild will take care of being forward compatible in this
> matter.
> 

Wouldn't it be better to have an option to tell make to assume the old 
behavior? I only skimmed the original thread but it didn't seem terribly 
complex thing to do. A LOT of people will be doing things on pre-2.6.17 
kernel for quite some time and they will be cursing a lot if they have 
to rebuild everything everytime.

Thanks.

-- 
tejun
