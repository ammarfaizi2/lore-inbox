Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129692AbRAHTUn>; Mon, 8 Jan 2001 14:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132002AbRAHTUh>; Mon, 8 Jan 2001 14:20:37 -0500
Received: from [64.64.109.142] ([64.64.109.142]:44304 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S129692AbRAHTU1>; Mon, 8 Jan 2001 14:20:27 -0500
Message-ID: <3A5A12D8.F10D3440@didntduck.org>
Date: Mon, 08 Jan 2001 14:19:52 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Steven_Snyder@3com.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Shared memory not enabled in 2.4.0?
In-Reply-To: <882569CE.0069993A.00@hqoutbound.ops.3com.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven_Snyder@3com.com wrote:
>      # cat /proc/meminfo
>              total:    used:    free:  shared: buffers:  cached:
>      Mem:  130293760 123133952  7159808        0 30371840 15179776

This is not SysV/POSIX shared memory.  This used to mean the memory that
was shared between processes (from librares etc.).  It became too
expensive to calculate so it was removed.  It only remains in
/proc/meminfo for backwards compatability with programs that parse that
file.

--

				Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
