Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVDIIAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVDIIAa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 04:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVDIIAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 04:00:30 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:42115 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261308AbVDIIAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 04:00:25 -0400
Subject: Re: [PATCH] restrict inter_module_* to its last users
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050408104826.3ca70fb4.akpm@osdl.org>
References: <20050408170805.GE2292@wohnheim.fh-wedel.de>
	 <20050408104826.3ca70fb4.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 09 Apr 2005 09:00:20 +0100
Message-Id: <1113033620.12012.28.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-08 at 10:48 -0700, Andrew Morton wrote:
> 
> > Next step for inter_module removal.  This patch makes the code
> >  conditional on its last users and shrinks the kernel binary for the
> >  huge majority of people.
> 
> If we do this, nobody will get around to fixing up the remaining
> users.

Oh, I'll fix them, and I'll be happy to see the back of the
inter_module_crap -- it went in over my objections in the first place.

But I want to deal with all the module / submodule loading crap first.
It all wants attention, and fixing up one deprecation warning alone is
just patching over the cracks.

-- 
dwmw2


