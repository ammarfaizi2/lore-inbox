Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261707AbSJNPKA>; Mon, 14 Oct 2002 11:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261757AbSJNPKA>; Mon, 14 Oct 2002 11:10:00 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:58637 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261707AbSJNPJ7>; Mon, 14 Oct 2002 11:09:59 -0400
Date: Mon, 14 Oct 2002 16:15:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Michael Clark <michael@metaparadigm.com>
Cc: Mark Peloquin <markpeloquin@hotmail.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: Linux v2.5.42
Message-ID: <20021014161545.B17683@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Michael Clark <michael@metaparadigm.com>,
	Mark Peloquin <markpeloquin@hotmail.com>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com,
	evms-devel@lists.sourceforge.net
References: <F87rkrlMjzmfv2NkkSD000144a9@hotmail.com> <3DA969F0.1060109@metaparadigm.com> <20021013144926.B16668@infradead.org> <3DA98E48.9000001@metaparadigm.com> <20021013163551.A18184@infradead.org> <3DA99CEC.8040208@metaparadigm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DA99CEC.8040208@metaparadigm.com>; from michael@metaparadigm.com on Mon, Oct 14, 2002 at 12:18:52AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 12:18:52AM +0800, Michael Clark wrote:
> one you decides. At the end of the day it is just another 'driver'
> and I don't think it's fair to place a higher benchmark of quality
> on EVMS than all the other drivers in the kernel

If you followed lkml you'll see that I even explain authors of
very small drivers how to fit the kernel standards.  The situation
with those is a little different as they are not a framework and
don't add new APIs.  Thus it's only a correctness and style issues.

EVMS on the other hand is not only a lot of code but also a framework,
i.e. it folows certain design principles.  And I fundamentally
disagree with some of those.

> Some of us have large arrays and SANs where the absence a volume
> manager is a big thing.

Not having EVMS ~= not having a volume manager.  I don't want
to have to manage my storage farms without a volume manager either,
but that doesn't have to mean that I like the EVMS design.

