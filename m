Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268914AbUJKMqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268914AbUJKMqf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 08:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268902AbUJKMpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 08:45:43 -0400
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:53218 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S268894AbUJKMnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 08:43:18 -0400
Message-ID: <416A7FE3.8090106@kolivas.org>
Date: Mon, 11 Oct 2004 22:43:15 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Cc: Ankit Jain <ankitjain1580@yahoo.com>, linux <linux-kernel@vger.kernel.org>
Subject: Re: Difference in priority
References: <20041011121726.10979.qmail@web52903.mail.yahoo.com> <416A7E25.8050101@kolivas.org>
In-Reply-To: <416A7E25.8050101@kolivas.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Ankit Jain wrote:
> 
>> hi
>>
>> if somebody knows the difference b/w /PRI of both
>> these commands because both give different results
>>
>> ps -Al
>> & top
>>
>> as per priority rule we can set priority upto 0-99
>> but top never shows this high priority
> 
> 
> Priority values 0-99 are real time ones and 100-139 are normal 
> scheduling ones. RT scheduling does not change dynamic priority while 
> running wheras normal scheduling does (between 100-139). top shows the 
> value of the current dynamic priority in the PRI column as the current 
> dynamic priority-100. If you have a real time task in top it shows as a 
> -ve value. ps -Al seems to show the current dynamic priority+60.

That should read dynamic priority-60 in the PRI column.

Cheers,
Con
