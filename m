Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275362AbTHSG3o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 02:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275365AbTHSG3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 02:29:44 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:46317 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S275362AbTHSG3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 02:29:41 -0400
Date: Tue, 19 Aug 2003 16:30:51 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/10] 2.6.0-t3: struct C99 initialiser conversion
Message-ID: <20030819063050.GA17577@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm... looks like 130k is too big for lk so I'll resend all split up.

----- Forwarded message from CaT <cat@zip.com.au> -----

Date: Tue, 19 Aug 2003 15:10:55 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Cc: kernel-janitor-discuss@lists.sf.net
Subject: [PATCH] 2.6.0-t3: struct C99 initialiser conversion
Organisation: Furball Inc.

Ok. I think I did it.

I used grep+sed at first and then went through the resulting patches,
fixing any problems by hand until I could spot no more. It was a lot
of fun weeding out the mistakenly changed bit-definitions but I think
I got them all. I also compiled the kernel with make allyesconfig, 
checking into compile failure for anything I broke. Obviously though,
the more people that check this the better.

Also, while I finally decided on a single patch, I can split if
need be. It's 100k and not that hard to go through, esp with syntax
highlighting (I should know... I went through it several times :)

Anyhow... here goes...

----- End forwarded message -----

-- 
"How can I not love the Americans? They helped me with a flat tire the
other day," he said.
	- http://tinyurl.com/h6fo
