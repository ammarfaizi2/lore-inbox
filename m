Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287817AbSBMQv7>; Wed, 13 Feb 2002 11:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287838AbSBMQvt>; Wed, 13 Feb 2002 11:51:49 -0500
Received: from pizda.ninka.net ([216.101.162.242]:55940 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S287817AbSBMQvp>;
	Wed, 13 Feb 2002 11:51:45 -0500
Date: Wed, 13 Feb 2002 08:49:52 -0800 (PST)
Message-Id: <20020213.084952.68037450.davem@redhat.com>
To: torvalds@transmeta.com
Cc: jgarzik@mandrakesoft.com, dalecki@evision-ventures.com,
        linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.5.4 i810_audio, bttv, working at all.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0202131028130.13632-100000@home.transmeta.com>
In-Reply-To: <3C6A5D79.33C31910@mandrakesoft.com>
	<Pine.LNX.4.33.0202131028130.13632-100000@home.transmeta.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Wed, 13 Feb 2002 10:30:48 -0800 (PST)
   
   Basic rule: it's up to _other_ architectures to fix drivers that don't
   work for them. Always has been. Because there's no way you can get the
   people who just want to have something working to care.

And if nobody else ends up doing it, you are right it will be people
like Jeff and myself doing it.

So what we are asking is to allow a few weeks for that and not crap up
the tree meanwhile.  This is so that the cases that need to be
converted are harder to find.

Actually, you're only half right in one regard.  Most people I've
pointed to Documentation/DMA-mapping.txt have responded "Oh, never saw
that before, that looks easy to do.  Thanks I'll fix it up properly
for you."
