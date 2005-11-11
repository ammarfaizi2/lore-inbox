Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbVKKKFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbVKKKFn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 05:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbVKKKFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 05:05:42 -0500
Received: from gateway.argo.co.il ([194.90.79.130]:47117 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S932320AbVKKKFm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 05:05:42 -0500
Message-ID: <43746CF2.5000501@argo.co.il>
Date: Fri, 11 Nov 2005 12:05:38 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: local denial-of-service with file leases
References: <43737CBE.2030005@argo.co.il> <20051111084554.GZ7991@shell0.pdx.osdl.net>
In-Reply-To: <20051111084554.GZ7991@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Nov 2005 10:05:40.0419 (UTC) FILETIME=[786BE130:01C5E6A7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:

>* Avi Kivity (avi@argo.co.il) wrote:
>  
>
>>the following program will oom a the 2.6.14.1 kernel, running as an 
>>ordinary user:
>>    
>>
>
>I don't have a good mechanism for testing leases, but this should fix
>the leak.  Mind testing?
>
>  
>
the test program of course passes, but now samba hangs when reading a 
file (mount -t cifs from the same machine). 2.6.14.1 reads the file but 
leaks memory.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

