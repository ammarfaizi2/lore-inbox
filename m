Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262523AbSJAXVU>; Tue, 1 Oct 2002 19:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262853AbSJAXUS>; Tue, 1 Oct 2002 19:20:18 -0400
Received: from pizda.ninka.net ([216.101.162.242]:193 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262524AbSJAXTq>;
	Tue, 1 Oct 2002 19:19:46 -0400
Date: Tue, 01 Oct 2002 16:18:10 -0700 (PDT)
Message-Id: <20021001.161810.40456340.davem@redhat.com>
To: torvalds@transmeta.com
Cc: perex@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA update [10/10] - 2002/08/05
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0210011607200.18575-100000@penguin.transmeta.com>
References: <Pine.LNX.4.33.0209302327500.503-100000@pnote.perex-int.cz>
	<Pine.LNX.4.33.0210011607200.18575-100000@penguin.transmeta.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Tue, 1 Oct 2002 16:22:33 -0700 (PDT)
   
   Talk to David about the problems with an external CVS tree, he had many of
   the same problems with his sparc/networking tree a long time ago. David, 
   maybe you can talk about how you solved them.
   
I basically tried to send patches on a daily basis.
If that failed... then I ended up with this huge diff
that I had to pick apart by hand like Alan does when merging
-ac bits.

Then I started to use bitkeeper, and I didn't have to go
through the pain of importing a new set of 2.5.x vanilla
changes before a merge.
