Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270754AbTHJWQS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 18:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270751AbTHJWQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 18:16:17 -0400
Received: from hell.org.pl ([212.244.218.42]:44548 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S270754AbTHJWQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 18:16:14 -0400
Date: Mon, 11 Aug 2003 00:16:40 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: Nathan Scott <nathans@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: [2.5/2.6] buffer layer error at fs/buffer.c:2800 when unlinking
Message-ID: <20030810221640.GA14257@hell.org.pl>
Mail-Followup-To: Nathan Scott <nathans@sgi.com>,
	linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
References: <20030803145113.GA31715@hell.org.pl> <20030806235908.GC854@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20030806235908.GC854@frodo>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Nathan Scott:
> This is indeed an XFS issue (thanks for reporting it), the
> patch below fixes it.

Thanks, it works fine now. I've still got one issue with XFS (this: [1] may
be helpful) left, though I didn't manage yet to reproduce it under
2.6.0-test3 (though I've seen it with 2.6.0-test2, even with the above
patch applied), so I'll start bothering you when (if, hopefully) this
happens. Thanks again,

[1] http://marc.theaimsgroup.com/?l=linux-xfs&m=105240964125502&w=2
    (I reported this once or twice on linux-xfs, however unsuccessfully)

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
