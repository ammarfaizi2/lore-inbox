Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbUKIGqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbUKIGqs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 01:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbUKIGqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 01:46:42 -0500
Received: from smtp.persistent.co.in ([202.54.11.65]:31674 "EHLO
	smtp.pspl.co.in") by vger.kernel.org with ESMTP id S261392AbUKIGoN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 01:44:13 -0500
Message-ID: <4190675A.70606@persistent.co.in>
Date: Tue, 09 Nov 2004 12:14:42 +0530
From: Sumesh <sumesh_kumar@persistent.co.in>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ych43 <ych43@student.canterbury.ac.nz>
CC: linux-kernel@vger.kernel.org
Subject: Re: select( ) function with socket
References: <418CC3ED@webmail>
In-Reply-To: <418CC3ED@webmail>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAQ=
X-White-List-Member: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

       On success, select returns the number  of  descriptors  contained 
in the descriptor sets, which may be zero if the timeout expires before 
anything happens. Hence its possible that maybe your timeout os set to zero.

Regards,
Sumesh



ych43 wrote:

>Hi,
> I use select( ) function of socket programming on linux. After this function, 
>I try to print the return value of select( ) function out. But there is no 
>return value coming out, even no any error out. So I do not know what's wrong 
>with this function. If I incorrectly used this function, some errors would 
>come out. But no any error comes out. Can anybody help me.
> Thank in advance!
> king regards
>  
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
