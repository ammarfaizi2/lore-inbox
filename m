Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266532AbUBLTMT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 14:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266556AbUBLTMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 14:12:19 -0500
Received: from cpc3-hitc2-5-0-cust51.lutn.cable.ntl.com ([81.99.82.51]:2702
	"EHLO zog.reactivated.net") by vger.kernel.org with ESMTP
	id S266532AbUBLTMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 14:12:18 -0500
Message-ID: <402BA5BD.9070307@reactivated.net>
Date: Thu, 12 Feb 2004 16:11:41 +0000
From: Daniel Drake <dan@reactivated.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Derek Foreman <manmower@signalmarketing.com>
Cc: Ross Dickson <ross@datscreative.com.au>, linux-kernel@vger.kernel.org,
       Jamie Lokier <jamie@shareable.org>, Ian Kumlien <pomac@vapor.com>,
       Jesse Allen <the3dfxdude@hotmail.com>,
       Craig Bradney <cbradney@zip.com.au>
Subject: Re: [PATCH] 2.6, 2.4, Nforce2, Experimental idle halt workaround
 instead of apic ack delay.
References: <200402120122.06362.ross@datscreative.com.au> <Pine.LNX.4.58.0402121118490.515@gonopodium.signalmarketing.com>
In-Reply-To: <Pine.LNX.4.58.0402121118490.515@gonopodium.signalmarketing.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Derek Foreman wrote:
> Is there a measurable performance loss over not having the patch at all?
> Some nforce2 systems work just fine.  Is there a way to distinguish
> between systems that need it and those that don't?

Do you have one of those systems to hand? My betting is on that when you 
enable APIC/IOAPIC you will see crashes very frequently. This isn't enabled in 
the default kernel config..

PS, Ross: Again, great work, thanks. I am running the patches you posted in 
the thread starter (without the previous ones) on 2.6.3-rc2-mm1 without problem.

Daniel
