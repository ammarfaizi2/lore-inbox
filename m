Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbVGLOnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVGLOnW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 10:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVGLOkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 10:40:45 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:11699 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S261491AbVGLOkb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 10:40:31 -0400
In-Reply-To: <20050712143620.GA4880@infradead.org>
Subject: Re: [patch] s390: fadvise hint values.
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Build V651_12042003 December 04, 2003
Message-ID: <OFBE89090B.2C1DA2DF-ON4225703C.00506327-4225703C.00509BC7@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Tue, 12 Jul 2005 16:40:27 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 12/07/2005 16:40:27
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Patch is attached, what do you think ?
>
> I'd rather fix the kernel and do some symbol versioning magic in
> glibc.  After all it's their stupidity that caused all these problems.

Well I was my stupidity that I copied the wrong fcntl.h file for s390-64.
The fcntl.h glibc header for alpha contained the "wrong" values and since
day 1 of the s390-64 port it has been 6 and 7 for us as well.

If we decide to fix the kernel we don't need to do anything in the glibc.

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH


