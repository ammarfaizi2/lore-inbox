Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbUCRHIX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 02:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbUCRHIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 02:08:23 -0500
Received: from alt.aurema.com ([203.217.18.57]:1704 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S262438AbUCRHIV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 02:08:21 -0500
Message-ID: <40594ADE.2020804@aurema.com>
Date: Thu, 18 Mar 2004 18:08:14 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: christian.guggenberger@physik.uni-regensburg.de
CC: linux-kernel@vger.kernel.org
Subject: Re: XFree86 seems to be being wrongly accused of doing the wrong
 thing
References: <1079593351.1830.12.camel@bonnie79>
In-Reply-To: <1079593351.1830.12.camel@bonnie79>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Guggenberger wrote:
>>With 2.6.4 I'm getting the following messages very early in the boot 
>>long before XFree86 is started:
>>
>>Mar 18 16:05:31 mudlark kernel: atkbd.c: Unknown key released 
>>(translated set 2, code 0x7a on isa0060/serio0).
>>Mar 18 16:05:31 mudlark kernel: atkbd.c: This is an XFree86 bug. It 
>>shouldn't access hardware directly.
>>
>>They are repeated 6 times and are NOT the result of any keys being 
>>pressed or released.
> 
> 
> this has been fixed in XFree86 HEAD (4.4.99.1)
> see changelog entry nr. 6 - the changes can easily be backported to 4.3.0, and work as expected on my box.
> (no noise anymore)

I repeat.  These messages are appearing when XFree86 is NOT running so 
there is no way that it can be the cause of them.

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

