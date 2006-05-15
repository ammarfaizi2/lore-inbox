Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWEOHdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWEOHdA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 03:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWEOHdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 03:33:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:30383 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751433AbWEOHc7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 03:32:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QCsjlfshd0L5nK+U9JKbSw6v+SAUhNNigUIGUKviVEkn4SXDBTVSfwEJ790a+l3hHwMwZ6rKi/F27sh1FAUa4mOMLoWVEm9+38JidG3X22uauPXKnf1v5N4DvV7pTqpvQeGsD6HG9YsVoAlwOOK/dr8lhYxEZ8LgF83Lwxerogc=
Message-ID: <67029b170605150032x686f1c5ek4bdf1087ca2a7cf9@mail.gmail.com>
Date: Mon, 15 May 2006 15:32:58 +0800
From: "Zhou Yingchao" <yingchao.zhou@gmail.com>
To: "Krishna Chaitanya" <lnxctnya@gmail.com>
Subject: Re: Linux for Asymmetric Multi Processing Systems.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <ae649ba00605112354k5b91cb0cwb5e67723f6560720@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <ae649ba00605112354k5b91cb0cwb5e67723f6560720@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your architecture is much like ours. Nowadays we are involing a
project named cluster_on_board, on which there are 4~16 cpus on a
board, these cpus can be the same and also can be different, and all
cpus can see all the memory. We are trying let each cpu running one
instance of kernel image(same or different), and communicate through
tcp/ip on a virtual Ethernet.  Of course, modifications are needed.

 I think you can do it in the same way. Or any more exciting ideas?

2006/5/12, Krishna Chaitanya <lnxctnya@gmail.com>:
> Hi All!
>
> I am working on a project where the hardware is Asymmetric Multi
> Processing Systems(ASMP).
>
> In my system I have one ARM9,  four ARM7s'.
>
> 1. Can I use one Linux Kernel for all the CPUs in an ASMP system. (or)
>    Should I use One Linux Kernel for ARM9 and RTOSes for ARM7.
> 2. If my hardware would come up in future with another ARM7 does linux
> scale for the new CPU.
>
> Can anyone please direct me to the source/docs how to use Linux for
> ASMP systems.
>
> Thanks,
> krs



-- 
Yingchao Zhou
***********************************************
 Institute Of Computing Technology
 Chinese Academy of Sciences
 Tel(O) : 010-62613792-28
***********************************************
