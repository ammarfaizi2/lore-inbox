Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265530AbUBAXxJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 18:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265531AbUBAXxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 18:53:09 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:27360 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265530AbUBAXw4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 18:52:56 -0500
Message-ID: <401D9154.9060903@cyberone.com.au>
Date: Mon, 02 Feb 2004 10:52:52 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Philip Martin <philip@codematters.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 slower than 2.4, smp/scsi/sw-raid/reiserfs
References: <87oesieb75.fsf@codematters.co.uk> <20040201151111.4a6b64c3.akpm@osdl.org>
In-Reply-To: <20040201151111.4a6b64c3.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Philip Martin <philip@codematters.co.uk> wrote:
>
>>The machine is a dual P3 450MHz, 512MB, aic7xxx, 2 disk RAID-0 and
>> ReiserFS.  It's a few years old and has always run Linux, most
>> recently 2.4.24.  I decided to try 2.6.1 and the performance is
>> disappointing.
>>
>
>2.6 has a few performance problems under heavy pageout at present.  Nick
>Piggin has some patches which largely fix it up.
>
>
>> My test is a software build of about 200 source files (written in C)
>> that I usually build using "nice make -j4".
>>
>
>Tried -j3?
>
>

Its got 512MB RAM though so its not swapping, is it?

Philip, can you please send about 30 seconds of vmstat 1
output for 2.4 and 2.6 while the test is running. Thanks

