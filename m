Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbUD1UIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbUD1UIM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 16:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUD1UHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 16:07:23 -0400
Received: from wirefire.bureaudepost.com ([66.38.187.209]:58587 "EHLO
	oasis.linuxant.com") by vger.kernel.org with ESMTP id S261742AbUD1Tl5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 15:41:57 -0400
In-Reply-To: <409006E6.5070406@techsource.com>
References: <20040427165819.GA23961@valve.mbsi.ca> <1083107550.30985.122.camel@bach> <47B669B0-98A7-11D8-85DF-000A95BCAC26@linuxant.com> <1083117450.2152.222.camel@bach> <1EF114FF-98C4-11D8-85DF-000A95BCAC26@linuxant.com> <408F99D5.1010900@aitel.hist.no> <3D29390A-992F-11D8-85DF-000A95BCAC26@linuxant.com> <409006E6.5070406@techsource.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1A22C4E6-994C-11D8-85DF-000A95BCAC26@linuxant.com>
Content-Transfer-Encoding: 7bit
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Helge Hafting <helgehaf@aitel.hist.no>
From: Marc Boucher <marc@linuxant.com>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Date: Wed, 28 Apr 2004 15:41:54 -0400
To: Timothy Miller <miller@techsource.com>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Apr 28, 2004, at 3:32 PM, Timothy Miller wrote:

>
>
> Marc Boucher wrote:
>
>>> I believe you have to remove the \0 to operate legally (or release 
>>> the full source under the GPL for real.)
>>> Your customer's problem is fixable though.  Either by also changing 
>>> the logging level
>>> so the message doesn't go out on the console, or by patching the 
>>> line with that printk() out of your customer's kernel.
>>> You can do this as a part of your install program.  If it gets too 
>>> hard, consider
>>> supplying the customer with your own precompiled kernel.
>> Thank you for the advice. However, if you knew our customers and 
>> understood their needs better you would realize that these are not 
>> feasible options.
>
>
> If your only "options" involve violating the GPL, then you cannot do 
> business in this area.

that's not what I said. What I said is that kernel patches are not an 
acceptable temporary workaround for the large installed base of average 
customers, since they generally cannot or do not want to bother 
recompiling stuff. We still make source for linux code and other parts 
required to allow the technically inclined to easily rebuild the 
modules and comply with the GPL.

>  "Someone won't let me release some code" isn't an excuse for breaking 
> the law.
>

  The proprietary code that cannot be released in source form is 
licensed material that was essentially developed by another party 
(Conexant) for other platforms. It clearly does not constitute a 
derived work of Linux.

Marc

--
Marc Boucher
Linuxant inc.

