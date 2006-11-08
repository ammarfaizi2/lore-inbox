Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754590AbWKHPEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754590AbWKHPEH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 10:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753226AbWKHPEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 10:04:06 -0500
Received: from wx-out-0506.google.com ([66.249.82.235]:37079 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1754590AbWKHPEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 10:04:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DjupI0ClXLDCGRVsbF/Sk8jicMa+kDUk9DW4NgZUfcV+WJUD/GBi0rsPINhAeB/HcxtndR5AK0qZKfL4ynC75rlSzXGQ/bLHE1FH3m0776mVmKzQXKjiY2B/cJCJ+I0GW1DaQLU6muEbn4FGsA1KiXmaXTklvUUs8bqfcovvYHM=
Message-ID: <3877989d0611080704j30b88bd4o4558e606fd6ffc11@mail.gmail.com>
Date: Wed, 8 Nov 2006 23:04:02 +0800
From: "Luming Yu" <luming.yu@gmail.com>
To: Stephen.Clark@seclark.us
Subject: Re: New laptop - problems with linux
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "Dave Jones" <davej@redhat.com>
In-Reply-To: <4551EC86.5010600@seclark.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4551EC86.5010600@seclark.us>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/06, Stephen Clark <Stephen.Clark@seclark.us> wrote:
> Hi list,
>
> I just purchased a VBI-Asus S96F laptop Intel 945GM &  ICH7, with a Core
> 2 Duo T560,0 2gb pc5400 memory.
>  From checking around it appeared all the
> hardware was well supported by linux - but I am having major problems.
>
>
> 1. neither the wireless lan Intel pro 3945ABG or built in ethernet
> RTL-8169C are detected and configured
> 2. the disk which is a 7200rpm Hitachi travelmate transfers data at 1.xx
> mb/sec
>    according to hdparm. This same drive in my old laptop an HP n5430 with a
>    850 duron the rate was 12-14 mb/sec.
>
> Attached are the output of lspci -vvv, dmesg and hdparm
> Any insight would be greatly appreciated.
>

Sounds like interrupt problem. Could you post /proc/interrupts?
It is worthy to try pci=noacpi.
