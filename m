Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbWEOIgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWEOIgQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 04:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWEOIgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 04:36:16 -0400
Received: from smtp15.clb.oleane.net ([213.56.31.158]:65152 "EHLO
	smtp15.clb.oleane.net") by vger.kernel.org with ESMTP
	id S964820AbWEOIgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 04:36:16 -0400
Message-ID: <44683D61.7000405@sej.fr>
Date: Mon, 15 May 2006 10:35:45 +0200
From: sej <sej@sej.fr>
Reply-To: sej@sej.fr
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org
Subject: Re: mlock into kernel module
References: <6bHKI-6a8-9@gated-at.bofh.it> <6bLbw-344-3@gated-at.bofh.it>
In-Reply-To: <6bLbw-344-3@gated-at.bofh.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright a écrit :
> * sej.kernel (sej.kernel@gmail.com) wrote:
>> I need to use mlock and munlock function into a kernel module. How so
>> I call this system call from my module ?
> 
> You shouldn't.
> 
>> I need to do this because I must use mlock in my software, but I can't
>> use root or suser to start it. So mlock alwaays fail.
> 
> You should be using rlimits for this.
> 
> thanks,
> -chris

So how to set rlimits ?
My program is in user mode and has to allocate about 128MB to 512MB of 
non swappable memory. Maybe I can change the rlimits rights into my 
kernel module ?
Do you know how to do this and where to find informations ?
Regards,
sej
