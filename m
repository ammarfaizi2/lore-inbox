Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265643AbUBBIpg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 03:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265646AbUBBIpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 03:45:36 -0500
Received: from imap.gmx.net ([213.165.64.20]:20965 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265643AbUBBIpf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 03:45:35 -0500
X-Authenticated: #4512188
Message-ID: <401E0E2C.8020708@gmx.de>
Date: Mon, 02 Feb 2004 09:45:32 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>
CC: Micha Feigin <michf@post.tau.ac.il>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: oops with 2.6.1-rc1 and rc-3
References: <BF1FE1855350A0479097B3A0D2A80EE0020AEB18@hdsmsx402.hd.intel.com> <1075664953.2389.12.camel@dhcppc4>
In-Reply-To: <1075664953.2389.12.camel@dhcppc4>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown wrote:
> On Sun, 2004-02-01 at 05:36, Prakash K. Cheemplavam wrote:
> 
> 
>>So there seems to be some serious issue since 2.6.2-rc2 going on.
>>Maybe
>>some ACPI related update?
> 
> 
> If you find that it goes away when you boot with pci=noacpi, or
> acpi=off, then it is likely an ACPI issue -- otherwise it is likely
> something else -- so give those a try and let me know.

Ok, I tried rc3 without acpi compiled in, and yes, it booted. So I guess 
acpi is really breaking up stuff. If you want me to test patches, let me 
know.

Prakash
