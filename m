Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264799AbTA1FrY>; Tue, 28 Jan 2003 00:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbTA1FrY>; Tue, 28 Jan 2003 00:47:24 -0500
Received: from dp.samba.org ([66.70.73.150]:65191 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264799AbTA1FrY>;
	Tue, 28 Jan 2003 00:47:24 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: no version magic, tainting kernel. 
In-reply-to: Your message of "Thu, 23 Jan 2003 11:35:40 -0800."
             <20030123193540.GD13137@ca-server1.us.oracle.com> 
Date: Tue, 28 Jan 2003 12:58:40 +1100
Message-Id: <20030128055643.AAC532C0F9@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030123193540.GD13137@ca-server1.us.oracle.com> you write:
> Can't the stuff in init/vermagic.c be moved into a header file? Maybe
> vermagic.h? Most of the code can be cut 'n pasted right out of vermagic.c
> and the bit that defines "const char vermagic[]..." could be placed inside a
> macro which modules would then stick in the bottom of one of their c files.

And then you'll die horribly next time Kai or I change the way modules
are built.

Really, using the Makefiles is always the most future-proof way!

Hope that helps!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
