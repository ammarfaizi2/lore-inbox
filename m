Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbTEMUFs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 16:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbTEMUFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 16:05:48 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:47830 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261994AbTEMUEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 16:04:00 -0400
Date: Tue, 13 May 2003 13:17:54 -0700
From: Andrew Morton <akpm@digeo.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix list, v2
Message-Id: <20030513131754.7f96d4d0.akpm@digeo.com>
In-Reply-To: <20030513163854.A27407@infradead.org>
References: <20030512155417.67a9fdec.akpm@digeo.com>
	<20030512155511.21fb1652.akpm@digeo.com>
	<1052834227.432.30.camel@dhcp22.swansea.linux.org.uk>
	<20030513163854.A27407@infradead.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 May 2003 20:16:41.0290 (UTC) FILETIME=[90DB1AA0:01C3198C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> That brings up another issue:  what ports do regularly work with 2.5
>  mainline?

I test ppc64 regularly.  In fact -mm is probably the best place to go to
get a working ppc64 tree at present.

But I do not view non-ia32 support as being a 2.6.0 requirement.  I'd be OK
with 2.6.0 working _only_ on ia32.  Other architectures will catch up when
they can.  The only core requirement is that 2.6.0 not contain gross
x86isms which make other ports impossible.

That's a rather lame position, and sure, one would wish otherwise.  Feel
free to disagree ;)
