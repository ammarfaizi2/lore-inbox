Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbUC2GRD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 01:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbUC2GRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 01:17:03 -0500
Received: from p3EE060D4.dip0.t-ipconnect.de ([62.224.96.212]:18816 "EHLO
	susi.maya.org") by vger.kernel.org with ESMTP id S262694AbUC2GRA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 01:17:00 -0500
Message-ID: <4067BF2C.8050801@p3EE060D4.dip0.t-ipconnect.de>
Date: Mon, 29 Mar 2004 08:16:12 +0200
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040212
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Very poor performance with 2.6.4
References: <40672F39.5040702@p3EE062D5.dip0.t-ipconnect.de> <20040328200710.66a4ae1a.akpm@osdl.org>
In-Reply-To: <20040328200710.66a4ae1a.akpm@osdl.org>
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Andreas Hartmann <andihartmann@freenet.de> wrote:
>>
>> I tested kernel 2.6.4. While compiling kdelibs and kdebase, I felt, that
>>  kernel 2.6 seems to be slower than 2.4.25.
>> 
>>  So I did some tests to compare the performance directly. Therefore I
>>  rebooted for everey test in init 2 (no X).
>> 
>>  I locally compiled 2.6.5rc2 3 times under 2.6.4 and under 2.4.25 on a
>>  reiserfs LVM partition, which resides onto a IDE HD (using DMA) and got
>>  the following result:
>> 
>>  In the middle, compiling under kernel 2.6.4 tooks 9.3% more real time than
>>  under 2.4.25.
>>  The user-processortime is about the same, but the system-processortime is
>>  under 2.6.4 32.9% higher than under 2.4.25.
> 
> Try mounting your reiserfs filesystems with the `-o nolargeio=1' option.

This didn't help.

> 
> If that doesn't help, please run a comparative kernel profile.  See
> Documentation/basic_profiling.txt.

I'll do this next.


Regards,
Andreas Hartmann
