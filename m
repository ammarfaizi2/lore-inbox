Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270568AbUJTXQC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270568AbUJTXQC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 19:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270557AbUJTXPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 19:15:37 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:38051 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269066AbUJTXMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 19:12:52 -0400
Date: Wed, 20 Oct 2004 16:12:41 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: maximilian attems <janitor@sternwelten.at>
cc: Hanna Linder <hannal@us.ibm.com>, kernel-janitors@lists.osdl.org,
       greg@kroah.com, linux-kernel@vger.kernel.org, perex@suse.cz,
       sailer@ife.ee.ethz.ch
Subject: Re: [KJ] Re: [Kernel-janitors] [PATCH 2.6.9-rc2-mm4 cmipci.c] [8/8]	Replace pci_find_device with pci_dev_present
Message-ID: <32220000.1098313960@w-hlinder.beaverton.ibm.com>
In-Reply-To: <20041020230128.GB1953@stro.at>
References: <28440000.1096502897@w-hlinder.beaverton.ibm.com> <20041020230128.GB1953@stro.at>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Thursday, October 21, 2004 01:01:28 AM +0200 maximilian attems <janitor@sternwelten.at> wrote:

>> +		if (!pci_dev_present(intel_82437vx)) 
>                                                     ^
>>  			snd_cmipci_set_bit(cm, CM_REG_MISC_CTRL, CM_TXVX);
>>  		break;
>>  	default:
>> 
>> 
> 
> a second one with small whitespace damage.
> fixed for next kjt.

Hi Max,

According to the CodingStyle I should not put a white space
after the function name and before the parenthesis. 

I do not believe that should be added.

Thanks.

Hanna

