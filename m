Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265885AbTAXX6N>; Fri, 24 Jan 2003 18:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265886AbTAXX6N>; Fri, 24 Jan 2003 18:58:13 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:35792 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265885AbTAXX6M>; Fri, 24 Jan 2003 18:58:12 -0500
Message-ID: <3E31D349.9B8CF412@us.ibm.com>
Date: Fri, 24 Jan 2003 15:59:06 -0800
From: Janet Morgan <janetmor@us.ibm.com>
Reply-To: janetmor@us.ibm.com
X-Mailer: Mozilla 4.72 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Hui_Ning@3com.com
CC: linux-kernel@vger.kernel.org
Subject: Re: epoll patch for 2.4.18
References: <OFBBFE5834.6A43553D-ON86256CB8.0078A5B3@3com.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sys_epoll 2.5.51 (which I believe is still current) was backported to 2.4.20 in
the following patch and should provide the support you're looking for:
http://marc.theaimsgroup.com/?l=linux-kernel&m=104009079418105&w=2
Note it won't apply cleanly to 2.4.18, but should be easy to rework.

Hui_Ning@3com.com wrote:

> hello,
>
> is there any epoll patch for 2.4.18 kernel that also supports tty, ppp file
> descriptor in addition to fds to pipe and socket ?
>
> thanks
>
> hui
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

