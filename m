Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276907AbRJ0TjI>; Sat, 27 Oct 2001 15:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276914AbRJ0Ti7>; Sat, 27 Oct 2001 15:38:59 -0400
Received: from host155.209-113-146.oem.net ([209.113.146.155]:9212 "EHLO
	tibook.netx4.com") by vger.kernel.org with ESMTP id <S276907AbRJ0Tir>;
	Sat, 27 Oct 2001 15:38:47 -0400
Message-ID: <3BDB0D56.3070305@mvista.com>
Date: Sat, 27 Oct 2001 15:39:02 -0400
From: Dan Malek <dan@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.10-pre5 ppc; en-US; 0.8) Gecko/20010419
X-Accept-Language: en
MIME-Version: 1.0
To: Kalyan <kalyand@cruise-controls.com>
CC: paulus@samba.org, linuxppc-dev@lists.linuxppc.org,
        ML-linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Wild Pointer!!!! ( some more info )
In-Reply-To: <03c101c15a76$7d067320$aac8a8c0@cruise> <15316.1504.603255.831736@cargo.ozlabs.ibm.com> <00b301c15ebc$2783dba0$aac8a8c0@cruise>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kalyan wrote:

> hi ,
>             after my failed attempts at 2.4.11 -pre 5 ...i decide to try
> 2.4.12.. ( from kernel.org.)...


What was the last kernel version that worked on this board?

> how can this be possible???? can i supect stack problems here?????

Anything is possible :-).  It could be an improperly initialized
data structure that contains an indirect function pointer, too.


	-- Dan

