Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262634AbVCCXQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbVCCXQc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 18:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbVCCW71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 17:59:27 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:18372 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262634AbVCCV6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 16:58:49 -0500
Date: Thu, 3 Mar 2005 21:58:31 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, torvalds@osdl.org, rmk+lkml@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303215831.GA16210@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Krzysztof Halasa <khc@pm.waw.pl>, Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@osdl.org>, greg@kroah.com, torvalds@osdl.org,
	rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002047.GA10434@kroah.com> <Pine.LNX.4.58.0503021710430.25732@ppc970.osdl.org> <20050303081958.GA29524@kroah.com> <4226CCFE.2090506@pobox.com> <20050303090106.GC29955@kroah.com> <4226D655.2040902@pobox.com> <20050303021506.137ce222.akpm@osdl.org> <4226EE0F.1050405@pobox.com> <m3vf88v7ox.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3vf88v7ox.fsf@defiant.localdomain>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 08:41:02PM +0100, Krzysztof Halasa wrote:
> > 2) After 2.6.11 release is out, there is no established process for
> > "oh shit, 2.6.11 users will really want that fixed."
> 
> We can do 2.6.11.x scheme. For the last stable kernel, of course
> (i.e., one additional small patchset). No more 2.6.11.x when 2.6.12
> is out.

I'd rather say we don't guarantee there will be one anymore after 2.6.<next>.2
is out.  First we need to provide it a little longer because .0 isn't alwaysas
stable as we want, second people will fix up older releases when they are
used as base kernel for distributions, and there's no point of not marking it
official if it is there.

