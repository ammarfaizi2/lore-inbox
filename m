Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264741AbUD2Uqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264741AbUD2Uqd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 16:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264830AbUD2Uqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 16:46:30 -0400
Received: from [213.133.118.2] ([213.133.118.2]:58514 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S264741AbUD2Upz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 16:45:55 -0400
Message-ID: <40916A5B.9060209@shadowconnect.com>
Date: Thu, 29 Apr 2004 22:49:31 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] I2O subsystem fixing and cleanup for 2.6
References: <40916612.4070206@shadowconnect.com> <20040429213747.A3701@infradead.org>
In-Reply-To: <20040429213747.A3701@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Christoph Hellwig wrote:
> On Thu, Apr 29, 2004 at 10:31:14PM +0200, Markus Lidel wrote:
> 
>>- i2o_block-cleanup.patch
>>   * more than 3 "visible" disks (hda, hdb, hdc, hdd) lead to kernel
>>     panics.
>>   * removes some unused code with partitions.
>>   * I2O_LOCK was often called with the addresses of the controller, and
>>     not with the address of the device. Fixed.
> Sounds like a good reason to completly kill the macro while we're at it.

Yep, you are right. The patch complety removes the macro.



Best regards,


Markus Lidel
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
