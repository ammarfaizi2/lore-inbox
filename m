Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281662AbRKUH6I>; Wed, 21 Nov 2001 02:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281667AbRKUH56>; Wed, 21 Nov 2001 02:57:58 -0500
Received: from queen.bee.lk ([203.143.12.182]:22251 "EHLO queen.bee.lk")
	by vger.kernel.org with ESMTP id <S281662AbRKUH5m>;
	Wed, 21 Nov 2001 02:57:42 -0500
Date: Wed, 21 Nov 2001 13:57:28 +0600
From: Anuradha Ratnaweera <anuradha@bee.lk>
To: Ishan Oshadi Jayawardena <ioshadi@sltnet.lk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.14 loopback blk dev compilation trouble
Message-ID: <20011121135728.A2996@bee.lk>
In-Reply-To: <3BFBBE98.68052D11@sltnet.lk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BFBBE98.68052D11@sltnet.lk>; from ioshadi@sltnet.lk on Wed, Nov 21, 2001 at 08:47:52AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2001 at 08:47:52AM -0600, Ishan Oshadi Jayawardena wrote:
>
> I've seen that the compilation of off-the-server 2.4.14 tree fails at the end
> of 'make bzImage' because drivers/block/loop.c uses the deactivate_page()
> function, which seems to have been removed from the source tree.

Remove the lines containing deactivate_page() and compilation should go
smoothly.  This problem was fixed in 2.4.15-pre1.

This was discussed on this list _many_ times.  Wonder how you missed ;)

Cheers,

Anuradha

-- 

Debian GNU/Linux (kernel 2.4.13)

To fear love is to fear life, and those who fear life are already three
parts dead.
		-- Bertrand Russell

