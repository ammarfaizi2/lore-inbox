Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131806AbRALPTG>; Fri, 12 Jan 2001 10:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131845AbRALPS4>; Fri, 12 Jan 2001 10:18:56 -0500
Received: from hera.cwi.nl ([192.16.191.1]:63223 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S131806AbRALPSw>;
	Fri, 12 Jan 2001 10:18:52 -0500
Date: Fri, 12 Jan 2001 16:18:28 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200101121518.QAA83968.aeb@ark.cwi.nl>
To: cw@f00f.org, rothwell@holly-springs.nc.us
Subject: Re: O_NONBLOCK, read(), select(), NFS, Ext2, etc.
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Chris Wedgwood <cw@f00f.org>

    On Thu, Jan 11, 2001 at 09:34:08PM -0500, Michael Rothwell wrote:

        The man pages for open, read and write say that if a file is opened
        using the O_NONBLOCK flag, then read() and write() will always return
        immediately and not block the calling process. 

    the man pages are wrong

Don't you think cc'ing the man page maintainer [aeb@cwi.nl]
would be a good idea whenever you think something is wrong
in the man pages? You never know, they might even improve.

In this particular case I don't think anything is actually
wrong, but I can well imagine that someone can invent clearer
wording. It would also be useful to more clearly separate
POSIX-mandated behaviour and actual Linux behaviour.
Suggestions and patches are welcome as always.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
