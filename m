Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030373AbWHAAdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030373AbWHAAdh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 20:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030374AbWHAAdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 20:33:37 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:27356 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030373AbWHAAdh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 20:33:37 -0400
Message-ID: <44CEA157.4050908@sgi.com>
Date: Mon, 31 Jul 2006 17:33:27 -0700
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jay Lan <jlan@sgi.com>
Cc: Shailabh Nagar <nagar@watson.ibm.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Balbir Singh <balbir@in.ibm.com>,
       Jes Sorensen <jes@sgi.com>, Chris Sturtivant <csturtiv@sgi.com>,
       Tony Ernst <tee@sgi.com>
Subject: Re: [patch 2/3] add CSA accounting to taskstats
References: <44CE5847.8050706@sgi.com> <44CE6A82.4060709@watson.ibm.com> <44CE7E4A.3050602@sgi.com>
In-Reply-To: <44CE7E4A.3050602@sgi.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan wrote:
> Shailabh Nagar wrote:
> 

<clip>

>>
>>> +     __u64    ac_chr;            /* bytes read */
>>> +     __u64    ac_chw;            /* bytes written */
>>> +     __u64    ac_scr;            /* read syscalls */
>>> +     __u64    ac_scw;            /* write syscalls */
>>
>>
>>
>> read_char,
>> write_char,
>> read_syscalls,
>> write_syscalls,
> 
> 
> Mmm, those are from task_struct.

Ooops, i was wrong. They were not from task_struct. Will change
to meaningful names as you suggested.

Regards,
- jay

> 
> Regards,
>  - jay
> 
> 
