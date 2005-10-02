Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbVJBKC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbVJBKC4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 06:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbVJBKC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 06:02:56 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:57356 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751050AbVJBKC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 06:02:56 -0400
Message-ID: <433FBE59.8000806@superbug.co.uk>
Date: Sun, 02 Oct 2005 12:02:49 +0100
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050930)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Why no XML in the Kernel?
References: <20051002094142.65022.qmail@web51012.mail.yahoo.com> <433FAD57.7090106@yahoo.com.au>
In-Reply-To: <433FAD57.7090106@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> Ahmad Reza Cheraghi wrote:
>
>> Can somebody tell me why the Kernel-Development dont
>> wanne have XML is being used in the Kernel??
>>
>
> Because nobody has come up with a good reason why it
> should be. Same as anything that isn't in the kernel.
>
> Nick
>
I have a requirement to pass information from the kernel to user space. 
The information is passed fairly rarely, but over time extra parameters 
are added. At the moment we just use a struct, but that means that the 
kernel and the userspace app have to both keep in step. If something 
like XML was used, we could implement new parameters in the kernel, and 
the user space could just ignore them, until the user space is upgraded.
XML would initially seem a good idea for this, but are there any methods 
currently used in the kernel that could handle these parameter changes 
over time.

For example, should the sysfs be used for this?

Any comments?

James

