Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262335AbSJQW6H>; Thu, 17 Oct 2002 18:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262336AbSJQW6H>; Thu, 17 Oct 2002 18:58:07 -0400
Received: from pizda.ninka.net ([216.101.162.242]:16320 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262335AbSJQW6G>;
	Thu, 17 Oct 2002 18:58:06 -0400
Date: Thu, 17 Oct 2002 15:56:30 -0700 (PDT)
Message-Id: <20021017.155630.98395232.davem@redhat.com>
To: jgarzik@pobox.com
Cc: ast@domdv.de, greg@kroah.com, hch@infradead.org, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove sys_security
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3DAF412A.7060702@pobox.com>
References: <20021017.131830.27803403.davem@redhat.com>
	<3DAF3EF1.50500@domdv.de>
	<3DAF412A.7060702@pobox.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff Garzik <jgarzik@pobox.com>
   Date: Thu, 17 Oct 2002 19:00:58 -0400
   
   Finally, I was under the impression that Greg KH agreed that it is 
   possible to eliminate this overhead?  Maybe I recall incorrectly.

The agreement was that it would be nice, we also agreed
that it's a very difficult thing to implement.

I'm now leaning more towards something like what Al Viro
hinted at earlier, creating generic per-file/fd attributes.
This kind of stuff.
