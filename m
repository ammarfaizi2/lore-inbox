Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbRADXUj>; Thu, 4 Jan 2001 18:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129348AbRADXUa>; Thu, 4 Jan 2001 18:20:30 -0500
Received: from duracef.shout.net ([204.253.184.12]:37394 "EHLO
	duracef.shout.net") by vger.kernel.org with ESMTP
	id <S129183AbRADXUR>; Thu, 4 Jan 2001 18:20:17 -0500
Date: Thu, 4 Jan 2001 17:19:51 -0600
From: Michael Elizabeth Chastain <mec@shout.net>
Message-Id: <200101042319.RAA19907@duracef.shout.net>
To: alan@lxorguk.ukuu.org.uk, kaos@ocs.com.au
Subject: Re: Make errors in 2.4 drivers/acpi, recursive CFLAGS
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder if Gnu Make 3.78.1 has the same problem?

I know of one bug in 3.78.1 where $(if ...) statements which have an
"else" clause screw up the parsing of the "else" clause.  But there
shouldn't be any $(if ...) constructs in the kernel Makefiles.

I guess we'll either have to find the problem and work around it,
or deprecate Gnu Make 3.78.

Michael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
