Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264247AbUFBWFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264247AbUFBWFD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 18:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264251AbUFBWFC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 18:05:02 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:49466 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S264247AbUFBWEy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 18:04:54 -0400
Message-ID: <40BE4EF6.6050001@microgate.com>
Date: Wed, 02 Jun 2004 17:04:38 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird M6a (Windows/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.6 synclinkmp.c
References: <20040527174509.GA1654@quadpro.stupendous.org> <1085769769.2106.23.camel@deimos.microgate.com> <20040528160612.306c22ab.akpm@osdl.org> <1086123061.2171.10.camel@deimos.microgate.com> <20040601215710.F31301@flint.arm.linux.org.uk> <1086125129.2047.21.camel@deimos.microgate.com> <20040602222257.A9322@flint.arm.linux.org.uk>
In-Reply-To: <20040602222257.A9322@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>Don't arrange for the driver to unload if it doesn't detect anything.
>2.6 has dynid support so that the user can load your driver and assign
>it extra PCI vendor/device IDs at run time - which won't work if you've
>forced failure when nothing is found.
>

That sounds reasonable.

I'll add that change and resubmit the patches for synclink.c and 
synclinkmp.c

--
Paul Fulghum
paulkf@microgate.com


