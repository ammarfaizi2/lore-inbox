Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272319AbTHIKju (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 06:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272320AbTHIKju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 06:39:50 -0400
Received: from mail.suse.de ([213.95.15.193]:30223 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S272319AbTHIKjt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 06:39:49 -0400
Subject: Re: [PATCH] 2.4: Restore current->files in flush_old_exec
From: Andreas Gruenbacher <agruen@suse.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030809100518.GA14688@gondor.apana.org.au>
References: <20030808105321.GA5096@gondor.apana.org.au>
	 <20030809010736.GA10487@gondor.apana.org.au>
	 <20030809011116.GB10487@gondor.apana.org.au>
	 <20030809014830.GA11509@gondor.apana.org.au>
	 <Pine.LNX.4.53.0308090418270.18879@Chaos.suse.de>
	 <20030809025311.GB11777@gondor.apana.org.au>
	 <Pine.LNX.4.53.0308090501090.18879@Chaos.suse.de>
	 <Pine.LNX.4.53.0308090518450.18879@Chaos.suse.de>
	 <Pine.LNX.4.53.0308090554160.18879@Chaos.suse.de>
	 <20030809100518.GA14688@gondor.apana.org.au>
Content-Type: text/plain
Organization: SuSE Labs, SuSE Linux AG
Message-Id: <1060425689.2100.33.camel@bree.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 09 Aug 2003 12:41:29 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 2003-08-09 at 12:05, Herbert Xu wrote:
> On Sat, Aug 09, 2003 at 05:54:32AM +0200, Andreas Gruenbacher wrote:
> > On Sat, 9 Aug 2003, Andreas Gruenbacher wrote:
> > 
> > > Here is an update ...
> > Do you agree that this is correct?
> 
> It looks OK to me.  However, I still think the BAD_ADDR change is
> unnecessary.

Very good, thanks. The BAD_ADDR change is indeed not required. It saves
a funtion call so I think we should keep it, but I don't mind so much.


Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SuSE Labs, SuSE Linux AG <http://www.suse.de/>


