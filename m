Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263049AbTIEOgN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 10:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbTIEOgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 10:36:13 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:54726 "EHLO
	executor.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S263049AbTIEOgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 10:36:12 -0400
Subject: Re: kernel header separation
From: David Woodhouse <dwmw2@infradead.org>
To: andersen@codepoet.org
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20030903014908.GB1601@codepoet.org>
References: <20030902191614.GR13467@parcelfarce.linux.theplanet.co.uk>
	 <20030903014908.GB1601@codepoet.org>
Content-Type: text/plain
Message-Id: <1062772560.32473.25.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5 (dwmw2) 
Date: Fri, 05 Sep 2003 15:36:01 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-02 at 19:49 -0600, Erik Andersen wrote:
> Header files intended for use by users should probably drop
> linux/types.h just include <stdint.h>,,,  Then convert the 
> types over to ISO C99 types.

Yes. Absolutely. In fact, we should do the rest of the kernel with as
much fervour as we've been changing struct initialisers... but at least
the user headers would be a good start.

-- 
dwmw2

