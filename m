Return-Path: <linux-kernel-owner+w=401wt.eu-S1760792AbWLHSAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760792AbWLHSAy (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 13:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760793AbWLHSAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 13:00:54 -0500
Received: from mta2.adelphia.net ([68.168.78.178]:59255 "EHLO
	mta2.adelphia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760792AbWLHSAx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 13:00:53 -0500
Message-ID: <4579A05E.2030706@acm.org>
Date: Fri, 08 Dec 2006 11:26:54 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>
Subject: Re: [PATCH 4/12] IPMI: Allow hot system interface remove
References: <20061202045606.GA31143@localdomain> <20061203132608.06434621.akpm@osdl.org>
In-Reply-To: <20061203132608.06434621.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Fri, 1 Dec 2006 22:56:06 -0600
> Corey Minyard <minyard@acm.org> wrote:
>
>   
>> This modifies the IPMI driver so that a lower-level interface can be
>> dynamically removed while in use so it can support hot-removal of
>> hardware.
>>
>> It also adds the ability to specify and dynamically change the
>> IPMI interface the watchdog timer and the poweroff code use.
>>
>>     
>
> Lots of new code here.  Has it all been runtime-tested under full debug
> mode and lockdep, as per Documentation/SubmitChecklist?
>   
Ok, done, no problems found.  Thanks.

-Corey
