Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269352AbUJLAAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269352AbUJLAAz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 20:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269358AbUJLAAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 20:00:55 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:12197 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269352AbUJLAAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 20:00:54 -0400
Message-ID: <416B1BB8.7020401@yahoo.com.au>
Date: Tue, 12 Oct 2004 09:48:08 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>
Subject: Re: Linux 2.6.9-rc4 - pls test (and no more patches)
References: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org> <416A5857.1090307@yahoo.com.au> <Pine.LNX.4.58.0410110802590.3897@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0410110802590.3897@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 11 Oct 2004, Nick Piggin wrote:
> 
>>ACPI still explodes on my old PII and stops it booting. (I've reported it
>>to Len a few times but he seems to be ignoring me).
> 
> 
> I suspect the "CONFIG_ACPI_BLACKLIST_YEAR" might be the solution they came 
> up with. Old ACPI stuff tends to be broken.
> 

True. I am using acpi=force afterall.

> That said, your patch is small and simple, so..
> 

OK you've merged it... well thanks. I guess considering I'm the only
one seeing this, it isn't going to impact anyone but me. Probably
avoiding an oops is a good thing even if it is due to broken hardware.
