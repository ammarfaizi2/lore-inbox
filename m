Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130645AbRAINwz>; Tue, 9 Jan 2001 08:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130463AbRAINwr>; Tue, 9 Jan 2001 08:52:47 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:6931 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129825AbRAINwc>;
	Tue, 9 Jan 2001 08:52:32 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200101091002.f09A2gw281603@saturn.cs.uml.edu>
Subject: Re: [PATCH] More compile warning fixes for 2.4.0
To: rth@twiddle.net (Richard Henderson)
Date: Tue, 9 Jan 2001 05:02:42 -0500 (EST)
Cc: J.A.K.Mouw@ITS.TUDelft.NL (Erik Mouw), richbaum@acm.org,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <20010108213044.A28968@twiddle.net> from "Richard Henderson" at Jan 08, 2001 09:30:44 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[about labels w/o statements after them]

>> Is this really a kernel bug? This is common idiom in C, so gcc
>> shouldn't warn about it. If it does, it is a bug in gcc IMHO.
>
> No, it is not a common idiom in C.  It has _never_ been valid C.
>
> GCC originally allowed it due to a mistake in the grammar; we
> now warn for it.  Fix your source.

Since neither -ansi nor -std=foo was specified, gcc should just
shut up and be happy. Consider this as another GNU extension.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
