Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751804AbWCNE1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbWCNE1Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 23:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752140AbWCNE1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 23:27:24 -0500
Received: from mta6.srv.hcvlny.cv.net ([167.206.4.201]:45641 "EHLO
	mta6.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1751804AbWCNE1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 23:27:24 -0500
Date: Mon, 13 Mar 2006 23:26:35 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [Patch 1/9] timestamp diff
In-reply-to: <661de9470603131942k768d672eq6009769ec58a4329@mail.gmail.com>
To: balbir@in.ibm.com
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
Message-id: <441645FB.6000002@watson.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
References: <1142296834.5858.3.camel@elinux04.optonline.net>
 <1142296939.5858.6.camel@elinux04.optonline.net>
 <1142298072.13256.70.camel@mindpipe>
 <1142298325.5858.40.camel@elinux04.optonline.net>
 <1142298764.13256.73.camel@mindpipe>
 <661de9470603131942k768d672eq6009769ec58a4329@mail.gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:

>>You don't think it's a problem that 2.0000001s - 1.9999999s would return
>>garbage rather than 0.0000002?
>>    
>>
Sorry....you're right. I was thinking of invalid deltas (where end was 
before start).

>>Lee
>>
>>    
>>
>
>The caller can use set_normalized_timespec() to fix that.
>  
>
Lee's point is valid....we should be doing the set_normalized_timespec.

Will fix.
Thanks,
Shailabh

>Warm Regards,
>Balbir
>  
>

