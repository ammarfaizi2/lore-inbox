Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132732AbRDUQHi>; Sat, 21 Apr 2001 12:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132734AbRDUQH2>; Sat, 21 Apr 2001 12:07:28 -0400
Received: from ns.caldera.de ([212.34.180.1]:6407 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S132732AbRDUQHS>;
	Sat, 21 Apr 2001 12:07:18 -0400
Date: Sat, 21 Apr 2001 18:06:34 +0200
Message-Id: <200104211606.SAA06630@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser)
Cc: linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: rwsem.o listed twice as export-objs
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20010420215330.N682@nightmaster.csn.tu-chemnitz.de>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010420215330.N682@nightmaster.csn.tu-chemnitz.de> you wrote:
> Hi David,
>
> please remove rwsem.o from the list of exported objects, if it is
> not used.

No!  The whole point of 'export-objs' is to _always_ list the objects there
to make the makefiles smaller and cleaner.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
