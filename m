Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266927AbUBMLRo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 06:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266941AbUBMLRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 06:17:44 -0500
Received: from pop.gmx.net ([213.165.64.20]:57828 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266927AbUBMLRm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 06:17:42 -0500
X-Authenticated: #4512188
Message-ID: <402CB24E.3070105@gmx.de>
Date: Fri, 13 Feb 2004 12:17:34 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ross@datscreative.com.au
CC: linux-kernel@vger.kernel.org, Jamie Lokier <jamie@shareable.org>,
       Ian Kumlien <pomac@vapor.com>, Jesse Allen <the3dfxdude@hotmail.com>,
       Craig Bradney <cbradney@zip.com.au>
Subject: Re: [PATCH] 2.6, 2.4, Nforce2, Experimental idle halt workaround
 instead of apic ack delay.
References: <200402120122.06362.ross@datscreative.com.au>
In-Reply-To: <200402120122.06362.ross@datscreative.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am just testing this patch with latest 2.6.3-rc2-mm1. It works in that 
sense, that my machine doesn't lock up of APIC issue. (If it locks up - 
hasn't done yet - then because of something else, I am currently 
discssing it in another thread...)

But it doesn't work in the sense of cooling my machine down. Though 
athcool reports disconnect is activated it behaves like it is not, ie, 
turning disconnect off makes no difference in temperatures. Your old 
tack patch in conjunction with 2.6.2-rc1 (linus) works like a charm, ie 
no lock-ups and less temp.

Any idea? I haven't taken out the apic_tack line, but I have added the 
idle=... line. Should that be a problem? I mean the apic_tack should 
safely be ignored, isn't it? Since I swap kernels quite often, I am too 
lazy to edit the boot line every time...

Prakash
