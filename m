Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424203AbWKIWfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424203AbWKIWfN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 17:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424204AbWKIWfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 17:35:12 -0500
Received: from 125.14.cm.sunflower.com ([24.124.14.125]:27612 "EHLO
	mail.atipa.com") by vger.kernel.org with ESMTP id S1424203AbWKIWfL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 17:35:11 -0500
Message-ID: <4553AD1F.4050206@atipa.com>
Date: Thu, 09 Nov 2006 16:35:11 -0600
From: Roger Heflin <rheflin@atipa.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Christoph Anton Mitterer <calestyo@scientia.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Strange write errors on FAT32 partition (maybe an FAT32 bug?!)
References: <4550A481.2010408@scientia.net> <87psbzrss2.fsf@duaron.myhome.or.jp> <4553744E.3050007@scientia.net> <45539188.5080607@atipa.com> <45539366.7070809@scientia.net> <45539588.7020504@atipa.com> <45539699.40105@scientia.net> <45539753.7060906@atipa.com> <4553A461.4080002@scientia.net> <4553A57C.5070503@atipa.com> <4553A6C9.4010906@scientia.net> <4553A84B.9050706@atipa.com> <4553AA8A.5080705@scientia.net>
In-Reply-To: <4553AA8A.5080705@scientia.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Nov 2006 22:36:09.0296 (UTC) FILETIME=[73AC7D00:01C7044F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Anton Mitterer wrote:
e.
>>   
> Ahh now I see:
> Parity Count:
> 
>         'pci_parity_count'
> 
>         This attribute file will display the number of parity errors that
>         have been detected.
> 
> 
> but this is zero ...
> So would that mean that I don't have any parity errors?
> 
> btw: I'm still always getting diff errors at different files...
> 
> Chris.
> 

That should mean that it is not a HW pci bus issue, though I
still have seen odd MB failures that cause corruption and don't
show anywhere (pci, ecc, mcelog), and only show up with cksums
on specific pieces of hw.

I don't have any good way of find those, we swapped one part
at a time until it went quit doing it.

                          Roger
