Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261911AbSJNQPs>; Mon, 14 Oct 2002 12:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261955AbSJNQPr>; Mon, 14 Oct 2002 12:15:47 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:35342 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261911AbSJNQPr>; Mon, 14 Oct 2002 12:15:47 -0400
Date: Mon, 14 Oct 2002 17:21:37 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Shawn <core@enodev.com>
Cc: Michael Clark <michael@metaparadigm.com>,
       Mark Peloquin <markpeloquin@hotmail.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: Linux v2.5.42
Message-ID: <20021014172137.D19897@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Shawn <core@enodev.com>, Michael Clark <michael@metaparadigm.com>,
	Mark Peloquin <markpeloquin@hotmail.com>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com,
	evms-devel@lists.sourceforge.net
References: <F87rkrlMjzmfv2NkkSD000144a9@hotmail.com> <3DA969F0.1060109@metaparadigm.com> <20021013144926.B16668@infradead.org> <3DA98E48.9000001@metaparadigm.com> <20021013163551.A18184@infradead.org> <20021014092048.A27417@q.mn.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021014092048.A27417@q.mn.rr.com>; from core@enodev.com on Mon, Oct 14, 2002 at 09:20:48AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 09:20:48AM -0500, Shawn wrote:
> Having said all that, given that your premises are true regarding the
> code design problems you have with EVMS, you have a valid point about
> including it in mainline. The question is, is this good enough to ignore
> having a logical device management system?!?

It is not good enough to ignore it.  It is good enough to postpone
integration for 2.7.

Now that Al has sorted out lots of the block device mess in 2.5
I will work together with whoever is interested in it (i.e. the EVMS
folks) to integrate proper higher-level volume-management into
the kernel once the next unstable series opens.

Coing up with lots of code just before feature freeze is just not the way
infrastructure work is done Linux.
