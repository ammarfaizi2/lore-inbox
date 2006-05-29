Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWE2Qlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWE2Qlx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 12:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWE2Qlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 12:41:53 -0400
Received: from mail.artecdesign.ee ([62.65.32.9]:40681 "EHLO
	postikukk.artecdesign.ee") by vger.kernel.org with ESMTP
	id S1751124AbWE2Qlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 12:41:52 -0400
Message-ID: <447B244A.6010008@artecdesign.ee>
Date: Mon, 29 May 2006 19:41:46 +0300
From: Indrek Kruusa <indrek.kruusa@artecdesign.ee>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Jordan Crouse <jordan.crouse@amd.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: long/heavy USB fs operations panics 2.6.16.18
References: <447495CC.7040205@artecdesign.ee> <20060524192503.GJ17964@cosmic.amd.com>
In-Reply-To: <20060524192503.GJ17964@cosmic.amd.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ADG-Spam-Score: -2.6 (--)
X-ADG-Spam-ScoreInt: -25
X-ADG-Spam-Report: Content analysis details:   (-2.6 points, 5.5 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
X-ADG-ExiScan-Signature: 06dfdebcc3f9f3e666e5dbcb028b2343
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jordan Crouse wrote:
> Hi Indrek -
>
>   
>> I am investigating a problem with a little custom Geode LX board. It has 
>> external USB ide hdd as root and it panics during long/heavy/? disk 
>> operation. E.g. 'du -sk /usr' or 'bzip2 -d linux-src.tar.bz2' in my /home.
>> Simplest (I suppose) example is fsck panic during boot (output,conf 
>> attached).
>>     
>
> Is the bug recreatable every single time when you try to fsck?
> Have you tried recreating the issue without EHCI?  That should help us
> at least narrow it down to the specific USB controller.  
>
> It seems to me like something is causing trouble down somewhere in the
> MM subsystem - its almost like something is walking over sensitive parts
> of memory - but be it stack or heap, I can't tell.
>   

Duh... I have to doublecheck it but currently it seems that our BIOS 
needs a fix. I hope you haven't had much trouble with my problem report. 
I much appreciate your feedback.

Best regards,
Indrek

