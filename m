Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbVJLHet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbVJLHet (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 03:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbVJLHet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 03:34:49 -0400
Received: from mf01.sitadelle.com ([212.94.174.68]:38998 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1751340AbVJLHet
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 03:34:49 -0400
Message-ID: <434CBC8E.40201@tremplin-utc.net>
Date: Wed, 12 Oct 2005 09:34:38 +0200
From: Eric Piel <Eric.Piel@tremplin-utc.net>
User-Agent: Mozilla Thunderbird 1.0.6-7mdk (X11/20050322)
X-Accept-Language: en, fr, ja, es
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] ppc64: Thermal control for SMU based machines
References: <1128404215.31063.32.camel@gaston>	 <20051011171052.3e1d00b6.akpm@osdl.org> <1129076588.17365.245.camel@gaston>
In-Reply-To: <1129076588.17365.245.camel@gaston>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

12.10.2005 02:23, Benjamin Herrenschmidt wrote/a écrit:
> On Tue, 2005-10-11 at 17:10 -0700, Andrew Morton wrote:
> 
> 
>>>+
>>>+	/* Alloc & initialize state */
>>>+	wf_smu_sys_fans = kmalloc(sizeof(struct wf_smu_sys_fans_state),
>>>+					GFP_KERNEL);
>>>+	if (wf_smu_sys_fans == NULL) {
>>>+		printk(KERN_WARNING "windfarm: Memory allocation error"
>>>+		       " max fan speed\n");
>>>+		goto fail;
>>>+	}
>>>+       	wf_smu_sys_fans->ticks = 1;
>>
>>whitespace broke.
> 
> 
> How so ? You mean the GFP_KERNEL a little bit too much on the right ? :)
> 
I think Andrew was talking about the spaces instead of tabs on the last 
line.

Eric
