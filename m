Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288127AbSAQCsx>; Wed, 16 Jan 2002 21:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288128AbSAQCsm>; Wed, 16 Jan 2002 21:48:42 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:53720 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S288127AbSAQCsb>;
	Wed, 16 Jan 2002 21:48:31 -0500
Date: Thu, 17 Jan 2002 13:47:53 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Joonas Koivunen <rzei@mbnet.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Power off NOT working, kernel 2.4.16
Message-Id: <20020117134753.4330b0b5.sfr@canb.auug.org.au>
In-Reply-To: <3C45F45C.5000005@mbnet.fi>
In-Reply-To: <3C45F45C.5000005@mbnet.fi>
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 16 Jan 2002 23:45:00 +0200
Joonas Koivunen <rzei@mbnet.fi> wrote:
>
> APM poweroff has actually been working with this computer, back when we 
> used 2.0.36 type kernels, and that one was possibly redhat patched or 
> something else, and windowses knew also how to poweroff, with mainboards
> drivers. APM poweroff seized to operate when I switched to 2.2 serie 
> kernels.

Have you checked your /etc/[rc.d/]init.d/halt script to make sure
that it is passing the "-p" option to "halt"?  This was a change
between the 2.0 and 2.2 kernels i.e. powerdown became separate
from halt.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
