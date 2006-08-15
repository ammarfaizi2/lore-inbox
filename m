Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030382AbWHOR6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030382AbWHOR6N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 13:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030408AbWHOR6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 13:58:13 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:51629 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1030382AbWHOR6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 13:58:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=EzwVWsFO88U3P+jyCPsrnfC4z5QCFvN4+eWf/ANKYs3lQZqG6dlNr258qSE/gbr5xAGlg9/tzKYsvZnDAxtLad27kqBeXYYSvatQBwAkMsXsBrwBkpGYypcEmdE+7EEIU0YGIpKcmibIjczTd6cVQZ8vMMBe8/BtvL5rs4rBHVI=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] UML - support checkstack
Date: Tue, 15 Aug 2006 19:57:59 +0200
User-Agent: KMail/1.9.1
Cc: Jeff Dike <jdike@addtoit.com>, Matt Mackall <mpm@selenic.com>,
       akpm@osdl.org, Joern Engel <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org
References: <200608091815.k79IFQVB005310@ccure.user-mode-linux.org> <20060810164548.GS6908@waste.org> <20060815031733.GA7089@ccure.user-mode-linux.org>
In-Reply-To: <20060815031733.GA7089@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608151957.59759.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 August 2006 05:17, Jeff Dike wrote:
> On Thu, Aug 10, 2006 at 11:45:48AM -0500, Matt Mackall wrote:
> > > SUBARCH has a different meaning here.  For UML, it's the underlying,
> > > host, architecture, not a variant architecture like Voyager.
> >
> > Right, so it sounds like this breaks Voyager. Which I think means we
> > ought to pass ARCH and SUBARCH and do the right thing inside
> > checkstack.
>
> There is no use of the symbol SUBARCH in arch/i386.  While this may be
> jarring to people who know and love Voyager, it doesn't break
> anything.
>
> We could do what you suggest, but that sounds unnecessary.
>
> I'd rather either
> 	leave things as they are
Yes, and make the script check if it ARCH=um or not (which is obvious for 
now - nobody really wants a clear abstraction here).
> 	rename SUBARCH

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
