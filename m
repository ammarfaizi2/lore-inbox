Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVDUMYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVDUMYl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 08:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVDUMYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 08:24:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:2479 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261151AbVDUMYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 08:24:38 -0400
Subject: Re: Git-commits mailing list feed.
From: David Woodhouse <dwmw2@infradead.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <1114079347.6277.29.camel@laptopd505.fenrus.org>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>
	 <1114079347.6277.29.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Thu, 21 Apr 2005 22:23:55 +1000
Message-Id: <1114086237.29135.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-21 at 12:29 +0200, Arjan van de Ven wrote:
> with BK this was not possible, but could we please have -p added to the
> diff parameters with git ? It makes diffs a LOT more reasable!

With BK this was not possible, but could you please provide your
criticism in 'diff -up' form?

I've done 'perl -pi -e s/-u/-up/ gitdiff-do' as a quick hack to provide
what you want, but a saner fix to make gitdiff-do obey the same
GIT_DIFF_CMD and GIT_DIFF_OPTS environment variables as show-diff.c
would be a more useful answer.

-- 
dwmw2

