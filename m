Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132556AbRCZTnn>; Mon, 26 Mar 2001 14:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132569AbRCZTnd>; Mon, 26 Mar 2001 14:43:33 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:6519 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S132556AbRCZTnW>; Mon, 26 Mar 2001 14:43:22 -0500
Message-ID: <3ABF9B40.6B93ECA2@sgi.com>
Date: Mon, 26 Mar 2001 11:40:48 -0800
From: LA Walsh <law@sgi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, en-US, en-GB, fr
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 64-bit block sizes on 32-bit systems
In-Reply-To: <009201c0b61e$c83f7550$5517fea9@local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> >4k page size * 2GB = 8TB.
> 
> Try it.
> If your drive (array) is larger than 512byte*4G (4TB) linux will eat
> your data.
---
	I have a block device that doesn't use 'sectors'.  It
only uses the logical block size (which is currently set for
1K).  Seems I could up that to the max blocksize (4k?) and
get 8TB...No?

	I don't use the generic block make request (have my
own).  

-- 
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338
