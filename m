Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262058AbVF0QhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbVF0QhX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 12:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVF0PBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 11:01:13 -0400
Received: from [81.2.110.250] ([81.2.110.250]:50124 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261255AbVF0OHI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 10:07:08 -0400
Subject: Re: reiser4 plugins
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Markus =?ISO-8859-1?Q?T=F6rnqvist?= <mjt@nysv.org>
Cc: Hans Reiser <reiser@namesys.com>, David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <20050627091808.GC11013@nysv.org>
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl>
	 <42BB31E9.50805@slaphack.com>
	 <1119570225.18655.75.camel@localhost.localdomain>
	 <42BB5E1A.70903@namesys.com>
	 <1119609680.17066.81.camel@localhost.localdomain>
	 <20050627091808.GC11013@nysv.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Message-Id: <1119880888.27005.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 27 Jun 2005 15:01:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-06-27 at 10:18, Markus Törnqvist wrote:
> Sure, "other people merge design-breakers and bugs" is NOT a justification
> for merging Reiser4, of course, but Reiser4's track record has vastly
> cleaned itself up.

The discussion is about merging from -mm, not into -mm. The merge into
-mm isn't at all under discussion so I don't the relevance of the
comparison.

> 0. Namesys addresses the code beautification reqs mentioned here earlier.
> 
> 1. Merge Reiser4 sans metas into 2.6.13.
> 2. Namesys can have a separate metas patch for testing.
> 3. Gradually merge Reiser4 architecture into VFS and if this really
>    requires a 2.7, as (iirc) Valdis Kletnieks suggested, make it so.
>    Might do the rest of the kernel some good too.

0 and 1 look like the first right steps to take to me as well. That will
allow people to use reiser4 and give it a good hammering see what comes
out and how it benches in real life. 

Alan

