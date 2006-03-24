Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422994AbWCXCkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422994AbWCXCkx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 21:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422993AbWCXCkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 21:40:53 -0500
Received: from bay109-dav14.bay109.hotmail.com ([64.4.19.86]:3755 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1422981AbWCXCkw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 21:40:52 -0500
Message-ID: <BAY109-DAV145F135DA57D0E819D208AB3DF0@phx.gbl>
X-Originating-IP: [72.60.172.10]
X-Originating-Email: [zhaojingmin@hotmail.com]
From: "Jing Min Zhao" <zhaojingmin@hotmail.com>
To: "Patrick McHardy" <kaber@trash.net>, "Adrian Bunk" <bunk@stusta.de>
Cc: <netdev@vger.kernel.org>, <zhaojingmin@users.sourceforge.net>,
       <netfilter-devel@lists.netfilter.org>,
       "Jing Min Zhao" <zhaojignmin@hotmail.com>,
       <linux-kernel@vger.kernel.org>
References: <20060324001307.GO22727@stusta.de> <44235324.3080607@trash.net>
Subject: Re: Two comments on the H.323 conntrack/NAT helper
Date: Thu, 23 Mar 2006 21:40:42 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-OriginalArrivalTime: 24 Mar 2006 02:40:51.0117 (UTC) FILETIME=[5D4C55D0:01C64EEC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Patrick McHardy" <kaber@trash.net>
To: "Adrian Bunk" <bunk@stusta.de>
Cc: <netdev@vger.kernel.org>; <zhaojingmin@users.sourceforge.net>; 
<netfilter-devel@lists.netfilter.org>; "Jing Min Zhao" 
<zhaojignmin@hotmail.com>; <linux-kernel@vger.kernel.org>
Sent: Thursday, March 23, 2006 9:02 PM
Subject: Re: Two comments on the H.323 conntrack/NAT helper


> [The hotmail address of the author doesn't work, CCed sourceforge-address]
>
> Adrian Bunk wrote:
>> Two comments on the H.323 conntrack/NAT helper:
>> - the function prototypes in ip_nat_helper_h323.c are _ugly_,
>>   please move them to a header file
>
> Their ugliness is because of the current API, which cleaned up
> quite a lot of the surrounding code, but requires this ugliness
> from each helper. I would like to keep them visible as a reminder
> that a cleaner solution is wanted, but moving them to header
> files certainly sound like a good idea to eliminate the risk
> of prototype conflicts. But please do this for all helpers
> at once.
>
>> - is there a reason for not using EXPORT_SYMBOL_GPL?
>
> I would prefer that too.
>
>

Sure, I'll do that.

Thanks

Jing Min Zhao 
