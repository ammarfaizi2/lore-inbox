Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312331AbSDCTHo>; Wed, 3 Apr 2002 14:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312332AbSDCTHe>; Wed, 3 Apr 2002 14:07:34 -0500
Received: from dark.pcgames.pl ([195.205.62.2]:31381 "EHLO dark.pcgames.pl")
	by vger.kernel.org with ESMTP id <S312331AbSDCTHX>;
	Wed, 3 Apr 2002 14:07:23 -0500
Date: Wed, 3 Apr 2002 21:11:09 +0200 (CEST)
From: Krzysztof Oledzki <ole@ans.pl>
X-X-Sender: <ole@dark.pcgames.pl>
To: <linux-kernel@vger.kernel.org>
cc: <alan@lxorguk.ukuu.org.uk>, <marcelo@conectiva.com.br>, <davej@suse.de>
Message-ID: <Pine.LNX.4.33.0204032104300.27291-100000@dark.pcgames.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Is there any reason why, after panic, 2.4.x kernels no longer response
for keyboard command like Shift-PgUp, Shift-PgDn or Ctrl+Alt+Del?

It is not possible to check why kernel is not able to find
init or mount root partition. Console scrolling with Shift-PgUp
is disabled! For example, it is very easy to forget to enable
"Boot off-board chipsets first support" for IDE.

Of course, one can say: "Use Serial Console!". Yes, this is true,
but I need null-modem, another computer and time for making new
kernel. Whit Shift-PgUp 5 seconds is too much and no other hardware
is required :))

And there is one more problem. When kernel is enabled to
automatically start Software RAID there is no way to
stop this RAID. Like I said - Ctrl+Alt+Del no longer works, so
next time all RAID arrays need to be synced. Ahhh!

So, is it possible to bring back Linux 2.2.x behavior? Please?

Best regards,


				Krzysztof Oledzki

