Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbTDDTmq (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 14:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbTDDTmq (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 14:42:46 -0500
Received: from static-ctb-210-9-247-181.webone.com.au ([210.9.247.181]:27140
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S261177AbTDDTmp (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 14:42:45 -0500
Message-ID: <3E8DE2D2.1070006@cyberone.com.au>
Date: Sat, 05 Apr 2003 05:53:54 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Joel Becker <Joel.Becker@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: WimMark I report for 2.5.66-mm3
References: <Pine.LNX.4.44.0304042041500.2378-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0304042041500.2378-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hugh Dickins wrote:

>On Fri, 4 Apr 2003, Joel Becker wrote:
>
>
>>WimMark I report for 2.5.66-mm3 
>>
>>Runs (deadline):  1736.51 1681.50 1010.98
>>Runs (antic):  579.62 496.75 517.06
>>
>>	WimMark I is a rough benchmark we have been running
>>here at Oracle against various kernels.  Each run tests an OLTP
>>workload on the Oracle database with somewhat restrictive memory
>>conditions.  etc. etc. etc.
>>
>
>No doubt the people who need to know do already know, but each time
>you post this I wish that the long exegesis accompanying the numbers
>would say whether a big number is better or worse than a small number.
>
A bigger number is better. AS does have something missing
in recent mms due to a bad interaction with SCSI, but it
is still around 20% below deadline for this test. It is
being worked on.

