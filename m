Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137115AbRAHLvW>; Mon, 8 Jan 2001 06:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143382AbRAHLvN>; Mon, 8 Jan 2001 06:51:13 -0500
Received: from nef.ens.fr ([129.199.96.32]:27411 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id <S137115AbRAHLvB>;
	Mon, 8 Jan 2001 06:51:01 -0500
Date: Mon, 8 Jan 2001 12:50:52 +0100
From: Thomas Pornin <Thomas.Pornin@ens.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: Extraneous whitespace removal?
Message-ID: <20010108125052.A27014@bolet.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010108044218.A9610@foozle.turbogeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010108044218.A9610@foozle.turbogeek.org> you write:
>  - I'm not yet positive there are no other places in the tree that
>    aren't safe to s/[<tab><space>]+$//. C can, if formated poorly
>    enough, be affected by it (multiline strings not ending with \).

Multiline strings not ending with \, are errors. gcc admits this
syntax but it is bad practice, and should be avoided.

For Makefile, DocBook, TeX and assembly, this should be ok too.

	--Thomas Pornin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
