Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbVKTVmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbVKTVmN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 16:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbVKTVmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 16:42:13 -0500
Received: from s0003.shadowconnect.net ([213.239.201.226]:945 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S932082AbVKTVmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 16:42:13 -0500
Message-ID: <4380EDB1.1080308@shadowconnect.com>
Date: Sun, 20 Nov 2005 22:42:09 +0100
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: alan@lxorguk.ukuu.org.uk, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] I2O: SPARC fixes
References: <437E7ADB.5080200@shadowconnect.com>	<20051118.172230.126076770.davem@davemloft.net>	<1132371039.5238.14.camel@localhost.localdomain> <20051118.203707.129707514.davem@davemloft.net>
In-Reply-To: <20051118.203707.129707514.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

David S. Miller wrote:
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Date: Sat, 19 Nov 2005 03:30:39 +0000
>>On Gwe, 2005-11-18 at 17:22 -0800, David S. Miller wrote:
>>>Ho hum, I guess keep it a config option for now until we find a
>>>way to auto-detect this reliably.
>>The notify functionality is mandatory. You are seeing the same cards
>>fail on sparc but work on x86. This sounds to me a lot more like an
>>unfound endian bug that needs fixing than a real lack of support
> That's very possible, but it also could be that the cards
> that fail only on Sparc have Sun forth firmware on them,
> which would thus only load firmware on Sparc boxes.
> I still think the endianness theory is more likely, however.
> Perhaps the I2O datastructures should be endian annotated
> and then pushed through sparse. :-)

Sounds good to me. Could i then find out if some BE<=>LE issues are still 
left? If so, is there a document which describes how it is done, or at 
least has a driver added it already?

Bye...
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
