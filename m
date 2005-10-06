Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751033AbVJFO1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbVJFO1I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 10:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbVJFO1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 10:27:07 -0400
Received: from [194.90.79.130] ([194.90.79.130]:58122 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1751020AbVJFO1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 10:27:06 -0400
Message-ID: <43453433.7000308@argo.co.il>
Date: Thu, 06 Oct 2005 17:26:59 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: PAE causing failure to run various executables.
References: <88056F38E9E48644A0F562A38C64FB6005EE9110@scsmsx403.amr.corp.intel.com> <1128604838.2960.42.camel@laptopd505.fenrus.org>
In-Reply-To: <1128604838.2960.42.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Oct 2005 14:27:01.0627 (UTC) FILETIME=[044754B0:01C5CA82]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>>Another possible reason can be NX(Execute Disable) support, which is 
>>active only on a PAE kernel. Trying "noexec=off" on a PAE kernel can be
>>tried here.
>>    
>>
>
>if that were the case them mem=4096M wouldn't solve the hangs..
>
>  
>
then bad memory is more likely. does mem= limit memory size to 4096MB, 
or does it limit the maximum physical address?
