Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129094AbRBCXuh>; Sat, 3 Feb 2001 18:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129129AbRBCXu1>; Sat, 3 Feb 2001 18:50:27 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:38663 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129094AbRBCXuN>;
	Sat, 3 Feb 2001 18:50:13 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200102032349.f13NnnP472493@saturn.cs.uml.edu>
Subject: Re: [reiserfs-list] Re: ReiserFS Oops (2.4.1, deterministic, symlink
To: alan@redhat.com (Alan Cox)
Date: Sat, 3 Feb 2001 18:49:49 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
        dwmw2@infradead.org (David Woodhouse), alan@redhat.com (Alan Cox),
        reiser@namesys.com (Hans Reiser), mason@suse.com (Chris Mason),
        kas@informatics.muni.cz (Jan Kasprzak), linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com,
        yura@yura.polnet.botik.ru (Yury Yu. Rupasov)
In-Reply-To: <200102031756.f13Hu4s13521@devserv.devel.redhat.com> from "Alan Cox" at Feb 03, 2001 12:56:04 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> [Albert Cahalan]
>> David Woodhouse writes:

>>>  -a "$CC" = "gcc"
>> 
>> Not worth it; they should upgrade the local gcc too.
>> If anything, they are getting a reminder that they need.
>
> The local gcc has no bearing on the compiler. The local
> compiler might not even be gcc - eg if they are cross
> building off non Linux systems

I know, and it still doesn't matter. So we test Solaris cc.
If it happens to have the same bug as gcc 2.96, then it is
broken and ought to be replaced.

I wouldn't want "menuconfig" messed up by a broken compiler,
even if I'm cross-compiling from HP-UX to sh4 Linux.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
