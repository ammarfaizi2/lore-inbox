Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291661AbSBAKI2>; Fri, 1 Feb 2002 05:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291662AbSBAKIS>; Fri, 1 Feb 2002 05:08:18 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:42904 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S291661AbSBAKH7>; Fri, 1 Feb 2002 05:07:59 -0500
Message-Id: <200202011007.g11A7hsc008080@tigger.cs.uni-dortmund.de>
To: "David S. Miller" <davem@redhat.com>
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does 
In-Reply-To: Message from "David S. Miller" <davem@redhat.com> 
   of "Thu, 31 Jan 2002 15:45:47 PST." <20020131.154547.74749379.davem@redhat.com> 
Date: Fri, 01 Feb 2002 11:07:42 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> said:

[...]

> However this isn't a driver, the crc library stuff is more akin to
> "strlen()".  Are you suggesting to provide a CONFIG_STRINGOPS=n
> too?  I wish you luck building that kernel :-)

libc.a was invented precisely to handle such stuff automatically when
linking... if it doesn't work, it should be fixed. I.e., making .a --> .o
is a step in the wrong direction IMVHO.
-- 
Horst von Brand			     http://counter.li.org # 22616
