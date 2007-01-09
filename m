Return-Path: <linux-kernel-owner+w=401wt.eu-S1751118AbXAIHHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbXAIHHS (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 02:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbXAIHHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 02:07:18 -0500
Received: from outmx007.isp.belgacom.be ([195.238.5.234]:35202 "EHLO
	outmx007.isp.belgacom.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbXAIHHQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 02:07:16 -0500
Message-ID: <45A33E93.9060908@246tNt.com>
Date: Tue, 09 Jan 2007 08:04:51 +0100
From: Sylvain Munaut <tnt@246tNt.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@ozlabs.org, Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
       paulus@samba.org
Subject: Re: Linux 2.6.20-rc4
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>	 <200701081550.27748.m.kozlowski@tuxland.pl> <45A25C17.5070606@246tNt.com>	 <1168303139.22458.246.camel@localhost.localdomain>	 <20070109005624.GA598@suse.de>	 <1168308323.22458.254.camel@localhost.localdomain> <1168326274.14763.313.camel@shinybook.infradead.org>
In-Reply-To: <1168326274.14763.313.camel@shinybook.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> On Tue, 2007-01-09 at 13:05 +1100, Benjamin Herrenschmidt wrote:
>   
>> Sylvain fixes are. My endian patches are for ps3 and toshiba celleb,
>> none of which is fully merged in 2.6.20 so they are fine to wait. It's
>> mostly a matter of being a PITA to rebase Sylvain stuff to apply before
>> mine and rebase mine on top of his I suppose :-) 
>>     
>
> Er, doesn't Efika need the same endian patches?
>   
No, Ben's patches are for controller that have registers in big-endian and
memory structures in little-endian.

52xx is full big-endian and that's already supported since quite some time
now.


    Sylvain

