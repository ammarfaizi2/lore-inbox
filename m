Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbTFBPqH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 11:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbTFBPqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 11:46:07 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:54522 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S262489AbTFBPqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 11:46:05 -0400
Subject: Re: [PATCH RFC] 1/2 central workspace for zlib
From: David Woodhouse <dwmw2@infradead.org>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-mtd@lists.infradead.org, matsunaga <matsunaga_kazuhisa@yahoo.co.jp>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030602155353.GB679@wohnheim.fh-wedel.de>
References: <20030530144959.GA4736@wohnheim.fh-wedel.de>
	 <002901c32919$ddc37000$570486da@w0a3t0>
	 <20030602153656.GA679@wohnheim.fh-wedel.de>
	 <1054568407.20369.382.camel@passion.cambridge.redhat.com>
	 <20030602155353.GB679@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=UTF-8
Organization: 
Message-Id: <1054569564.20369.385.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Mon, 02 Jun 2003 16:59:25 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-02 at 16:53, Jörn Engel wrote:
> Maybe lazy allocation.  vmalloc() it with the first write(), which
> should be never in production use.  So the extra overhead doesn't
> really matter.

Seems reasonable.

> Do you mind if I submit such a patch?

For the CVS code, which is what's in 2.5, please do. Don't bother with
2.4; I rewrote all the block translation layer crap so the individual
translation drivers doesn't have to be too involved with the horridness
of the Linux block layer.

-- 
dwmw2

