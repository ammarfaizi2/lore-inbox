Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130537AbRCDWlm>; Sun, 4 Mar 2001 17:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130540AbRCDWlc>; Sun, 4 Mar 2001 17:41:32 -0500
Received: from colorfullife.com ([216.156.138.34]:57864 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130537AbRCDWlR>;
	Sun, 4 Mar 2001 17:41:17 -0500
Message-ID: <3AA2C488.54A792AD@colorfullife.com>
Date: Sun, 04 Mar 2001 23:41:12 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-14 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: kenn@linux.ie
CC: linux-kernel@vger.kernel.org
Subject: Re: kmalloc() alignment
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Does kmalloc() make any guarantees of the alignment of allocated 
> blocks? Will the returned block always be 4-, 8- or 16-byte 
> aligned, for example? 
>

4-byte alignment is guaranteed on 32-bit cpus, 8-byte alignment on
64-bit cpus.

--
	Manfred
