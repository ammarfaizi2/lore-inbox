Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261349AbTCTJmG>; Thu, 20 Mar 2003 04:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261351AbTCTJmG>; Thu, 20 Mar 2003 04:42:06 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:42500 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S261349AbTCTJmF>; Thu, 20 Mar 2003 04:42:05 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303200955.h2K9t677000483@81-2-122-30.bradfords.org.uk>
Subject: Re: Deprecating .gz format on kernel.org
To: hpa@zytor.com (H. Peter Anvin)
Date: Thu, 20 Mar 2003 09:55:06 +0000 (GMT)
Cc: mirrors@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <3E78D0DE.307@zytor.com> from "H. Peter Anvin" at Mar 19, 2003 12:19:42 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At some point it probably would make sense to start deprecating .gz
> format files from kernel.org.

Presumably the idea is to save bandwidth.  In that case, it might be
simpler to add:

<h1>.gz is depreciated and will be removed soon!</h1>
Please start using .bz2 immediately.  .gz downloads are rate limited
to 5kbps.

to index.html :-).

Seriously, there are occasions when you're patching a kernel on a 486
or something, that it's quicker to use the .gz than the .bz2, even
including the download time, (if you're on a fast connection).
However, there are probably a lot of people downloading .gz, because
they don't know what .bz2 is.

Likewise, http access to kernel.org is frequently slow, whereas ftp
access can use 100% of my link, simply because many more people use
http.

One other thing that occurs to me, the send your e-mail address as
anonymous password requirement means I can't use wget to access the
ftp site, (I think - the user:password@host syntax seems to confuse
it, when it's anonymous:me@mydomain@ftp.site).

John.
