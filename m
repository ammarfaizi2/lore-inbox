Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129132AbRBALss>; Thu, 1 Feb 2001 06:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129269AbRBALsi>; Thu, 1 Feb 2001 06:48:38 -0500
Received: from silver.sucs.swan.ac.uk ([137.44.10.1]:64261 "EHLO
	sucs.swan.ac.uk") by vger.kernel.org with ESMTP id <S129132AbRBALs0>;
	Thu, 1 Feb 2001 06:48:26 -0500
Message-ID: <4755.137.44.4.15.981028098.squirrel@www.sucs.swan.ac.uk>
Date: Thu, 1 Feb 2001 11:48:18 -0000 (GMT)
Subject: Need for more ISO8859 codepages?
From: "Rhys Jones" <linux-kernel@postwales.com>
To: linux-kernel@vger.kernel.org
X-Mailer: SquirrelMail (version 1.0pre2)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Please forgive a semi-newbie post.

About 18 months ago I patched fs/nls/ to include support for the
Celtic character set, ISO8859-14. I notice that there are still gaps
in nls, specifically in ISO8859 codepages 10 to 13.

The missing codepages are for Nordic/Icelandic (ISO8859-10), Thai
(ISO8859-11), and Baltic Rim (ISO8859-13) languages. I'm still trying
to determine the status of ISO8859-12 at the moment.

Two questions, really. The general one is whether anyone would find
these codepages useful. If they would, I'm willing to provide the
patches in due course. More specifically, can anyone tell me why
ISO8859-10 (Icelandic etc.) is mentioned in Documentation/Configure.help
whilst nls_iso8859-10.c is missing from the fs/nls directory?

Any and all feedback appreciated.

Thanks,
Rhys Jones, Swansea
-- 
http://www.sucs.org/~rhys/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
