Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270203AbUJTL5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270203AbUJTL5Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 07:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270200AbUJTLyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 07:54:32 -0400
Received: from webapps.arcom.com ([194.200.159.168]:37390 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S270122AbUJTLwc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 07:52:32 -0400
Message-ID: <4176517C.4090504@arcom.com>
Date: Wed, 20 Oct 2004 12:52:28 +0100
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Harald Welte <laforge@gnumonks.org>,
       Jeff Chua <jeffchua@silk.corp.fedex.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, LARTC@mailman.ds9a.nl
Subject: Re: iproute2 and 2.6.9 kernel headers (was Re: [ANNOUNCE] iproute2
 2.6.9-041019)
References: <41758014.4080502@osdl.org>	 <Pine.LNX.4.61.0410200805110.8475@boston.corp.fedex.com>	 <20041020070017.GA19899@sunbeam.de.gnumonks.org>	 <20041020094123.GF19899@sunbeam.de.gnumonks.org> <1098268885.3872.81.camel@baythorne.infradead.org>
In-Reply-To: <1098268885.3872.81.camel@baythorne.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Oct 2004 11:52:41.0234 (UTC) FILETIME=[4DA93F20:01C4B69B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> 
> The time has come to fix it properly instead. Anything which these tools
> actually need from the kernel headers should be moved into a separate
> header file (still in the kernel source) which is usable from _both_
> kernel and userspace.

Isn't this what linux-libc-headers is for?

> It should use standard types (like uint16_t etc)

Why doesn't the kernel use these standard types also?

David Vrabel
--
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/
