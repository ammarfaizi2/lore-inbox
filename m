Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbUKDDCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbUKDDCq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 22:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbUKDDCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 22:02:37 -0500
Received: from tueddeln.de ([217.160.187.172]:49046 "EHLO
	p15131177.pureserver.info") by vger.kernel.org with ESMTP
	id S261646AbUKDC7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 21:59:31 -0500
Message-ID: <41899B0F.6070200@babut.net>
Date: Thu, 04 Nov 2004 03:59:27 +0100
From: Thomas Babut <thomas@babut.net>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: George Glover <hyperborean@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.x hangs with Symbios Logic 53c1010 Ultra3 SCSI Adapter
References: <41898E16.8090908@babut.net> <a99a678a04110318572509fb7b@mail.gmail.com>
In-Reply-To: <a99a678a04110318572509fb7b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Glover wrote:
> On Thu, 04 Nov 2004 03:04:06 +0100, Thomas Babut <thomas@babut.net> wrote:
> 
>>Dual Pentium III at 1000 MHz with 1 GByte RAM and Quantum ATLAS10K2-TY367J
> 
> ...
> 
>>sym0:1:0: ABORT operation started.
>>sym0:1:0: ABORT operation timed-out.
>>sym0:1:0: DEVICE RESET operation started.
>>sym0:1:0: DEVICE RESET operation timed-out.
>>sym0:1:0: BUS RESET operation started.
>>sym0: SCSI BUS reset detected.
>>sym0: SCSI BUS has been reset.
>>sym0: SCSI BUS operation completed.
>>
>>At this point only a hard-reset helps.
> 
> 
> You need to upgrade to a more recent kernel, I had the same problem -
> it's a known issue with the hard disk's firmware.  That particular
> version of the symbios driver added domain validation code which
> triggers the bug, the are work-arounds in the latest stable kernel.
> 
> George

Which latest Kernel do you mean exactly? I've tried it with 2.6.9, 
2.6.10-rc1-bk13, 2.6.10-rc1-mm2 with no success.

Thanks.

Regards,
Thomas
