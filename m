Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131155AbRAQNgR>; Wed, 17 Jan 2001 08:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132140AbRAQNgH>; Wed, 17 Jan 2001 08:36:07 -0500
Received: from smtp.mountain.net ([198.77.1.35]:64518 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S131155AbRAQNf5>;
	Wed, 17 Jan 2001 08:35:57 -0500
Message-ID: <3A659FBF.8999BBD6@mountain.net>
Date: Wed, 17 Jan 2001 08:35:59 -0500
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0 i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: Peter Horton <pdh@colonel-panic.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1-pre8 and Athlon
In-Reply-To: <20010117114211.B1315@colonel-panic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Horton wrote:
> 
> Building 2.4.1-pre8 for K7 gives 'current' undefined errors in the headers
> included from init/main.c. Looks like something included from asm/string.h
> is missing an include. The problems go away if I remove
> CONFIG_X86_USE3DNOW=y from the config.
> 
> P.

The other choices are to disable SMP, or use one of the patches posted here:
Petr Vandrovec's or mine.

Tom
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
