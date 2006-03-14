Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752153AbWCNESL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153AbWCNESL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 23:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbWCNESL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 23:18:11 -0500
Received: from mta8.srv.hcvlny.cv.net ([167.206.4.203]:44428 "EHLO
	mta8.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1751211AbWCNESK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 23:18:10 -0500
Date: Mon, 13 Mar 2006 23:18:06 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [Patch 9/9] Generic netlink interface for delay accounting
In-reply-to: <1142304506.5219.34.camel@jzny2>
To: hadi@cyberus.ca
Cc: Matt Helsley <matthltc@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>
Message-id: <441643FE.6040101@watson.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
References: <1142296834.5858.3.camel@elinux04.optonline.net>
 <1142297791.5858.31.camel@elinux04.optonline.net>
 <1142303607.24621.63.camel@stark> <1142304506.5219.34.camel@jzny2>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:

>On Mon, 2006-13-03 at 18:33 -0800, Matt Helsley wrote:
>  
>
>>On Mon, 2006-03-13 at 19:56 -0500, Shailabh Nagar wrote:
>>    
>>
>
>  
>
>>Jamal, was your Mon, 13 Mar 2006 21:29:09 -0500 reply:
>>    
>>
>>>Note, you are still not following the standard scheme of doing things.
>>>Example: using command = GET and the message carrying the TGID to note
>>>which TGID is of interest. Instead you have command = TGID.
>>>
>>>      
>>>
>
>  
>
>>meant to suggest that TASKSTATS_CMD_(P|TG)ID should be renamed to
>>TASKSTATS_CMD_GET_(P|TG)ID ? Is that sufficient? Or am I
>>misunderstanding?
>>
>>    
>>
>
>I had a long description in an earlier email feedback; but the summary
>of it is the GET command is generic like TASKSTATS_CMD_GET; the message
>itself carries TLVs of what needs to be gotten which are 
>either PID and/or TGID etc. Anyways, theres a long spill of what i am
>saying in that earlier email. Perhaps the current patch is a transition
>towards that?
>  
>

Yes, the comments you'd made in the previous mail have not been
incorporated and this is still the older version of the patch.
We'd been avoiding TLV usage so far :-)

>cheers,
>jamal 
>
>  
>

