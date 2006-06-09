Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030554AbWFIWAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030554AbWFIWAH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 18:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030556AbWFIWAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 18:00:06 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:52390 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030554AbWFIWAF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 18:00:05 -0400
Message-ID: <4489EF63.4090008@garzik.org>
Date: Fri, 09 Jun 2006 18:00:03 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <E1Fomsf-0007hZ-7S@w-gerrit.beaverton.ibm.com> <4489D36C.3010000@garzik.org> <20060609203523.GE10524@thunk.org> <4489EAFE.6090303@garzik.org> <e6cq1r$foi$1@terminus.zytor.com> <4489EEA7.8010704@garzik.org> <4489EF01.30001@zytor.com>
In-Reply-To: <4489EF01.30001@zytor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Jeff Garzik wrote:
>>
>> Right, and that proves my point.  When you start making major changes 
>> like 32->64 bit block numbers, you should communicate to the user 
>> (with a big blinky "ext4" sign) that his filesystem metadata will 
>> change a lot, not a little.  Not to mention that such code will add 
>> yet more "if (new) .. else .." code.
>>
> 
> Forking the code and registering another filesystem name are two 
> separate things, though.

Certainly.  Hopefully one would follow the other, for maximum benefit.

	Jeff




