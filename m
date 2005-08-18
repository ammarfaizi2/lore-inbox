Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbVHROSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbVHROSb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 10:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbVHROSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 10:18:31 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:15866 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750823AbVHROSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 10:18:30 -0400
Subject: Re: [PATCH] Fix mmap_kmem (was: [question] What's the
	difference	between /dev/kmem and /dev/mem)
From: Steven Rostedt <rostedt@goodmis.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1124374025.3220.14.camel@laptopd505.fenrus.org>
References: <1123796188.17269.127.camel@localhost.localdomain>
	 <1123809302.17269.139.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0508120930150.3295@g5.osdl.org>
	 <1123951810.3187.20.camel@laptopd505.fenrus.org>
	 <130440000.1124031022@[10.10.2.4]>
	 <1124374025.3220.14.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 18 Aug 2005 10:18:10 -0400
Message-Id: <1124374690.5186.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-18 at 16:07 +0200, Arjan van de Ven wrote:
> > Whilst there's no normal legitimite usage for it, it is useful for debugging.
> > One thing I often do is create a circular log buffer, then fish it back 
> > out by mmaping /dev/mem or /dev/kmem, and going by system.map offsets.
> > No, nobody could claim it was clean or elegant, but it *is* useful.
> 
> relayfs.

It's still not in the vanilla kernel. Besides, mapping kmem is more
fun :-)

-- Steve


