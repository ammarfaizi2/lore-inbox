Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424210AbWKIWmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424210AbWKIWmu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 17:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424213AbWKIWmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 17:42:49 -0500
Received: from 125.14.cm.sunflower.com ([24.124.14.125]:25821 "EHLO
	mail.atipa.com") by vger.kernel.org with ESMTP id S1424210AbWKIWms
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 17:42:48 -0500
Message-ID: <4553AEE8.8080003@atipa.com>
Date: Thu, 09 Nov 2006 16:42:48 -0600
From: Roger Heflin <rheflin@atipa.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Christoph Anton Mitterer <calestyo@scientia.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Strange write errors on FAT32 partition (maybe an FAT32 bug?!)
References: <4550A481.2010408@scientia.net> <87psbzrss2.fsf@duaron.myhome.or.jp> <4553744E.3050007@scientia.net> <45539188.5080607@atipa.com> <45539366.7070809@scientia.net> <45539588.7020504@atipa.com> <45539699.40105@scientia.net> <45539753.7060906@atipa.com> <4553A461.4080002@scientia.net> <4553A57C.5070503@atipa.com> <4553A6C9.4010906@scientia.net> <4553A84B.9050706@atipa.com> <4553AA8A.5080705@scientia.net> <4553AD1F.4050206@atipa.com> <4553ADF5.3070002@scientia.net>
In-Reply-To: <4553ADF5.3070002@scientia.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Nov 2006 22:43:46.0812 (UTC) FILETIME=[845FE3C0:01C70450]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Anton Mitterer wrote:
> Roger Heflin wrote:
>> That should mean that it is not a HW pci bus issue, though I
>> still have seen odd MB failures that cause corruption and don't
>> show anywhere (pci, ecc, mcelog), and only show up with cksums
>> on specific pieces of hw.
>>
>> I don't have any good way of find those, we swapped one part
>> at a time until it went quit doing it.
> Would those errors also occur when just calculating message digests
> (sha1sum)? Because if so,.. I could exclude those types of errors for my
> issue because as I've told,.. at least on the original files the sha
> sums always are correct.
> 
> Regards,
> Chris.

Usually it seemed to be IO related, the sums just happened
to show it issue.   It did not seem to be a cpu issue,
something unknown outside of the cpu seemed to cause it.

                              Roger
