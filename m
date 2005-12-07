Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbVLGMlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbVLGMlT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 07:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbVLGMlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 07:41:19 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:4758 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751002AbVLGMlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 07:41:18 -0500
Date: Wed, 7 Dec 2005 12:41:10 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Benjamin LaHaise <bcrl@kvack.org>, Michael Poole <mdpoole@troilus.org>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
Message-ID: <20051207124110.GA17895@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Helge Hafting <helge.hafting@aitel.hist.no>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Michael Poole <mdpoole@troilus.org>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <1133779953.9356.9.camel@laptopd505.fenrus.org> <200512051826.06703.andrew@walrond.org> <1133817575.11280.18.camel@localhost.localdomain> <1133817888.9356.78.camel@laptopd505.fenrus.org> <1133819684.11280.38.camel@localhost.localdomain> <4394D396.1020102@am.sony.com> <20051206041215.GC26602@kroah.com> <87iru2c0zc.fsf@graviton.dyn.troilus.org> <20051206172153.GB22502@kvack.org> <4396D814.5070809@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4396D814.5070809@aitel.hist.no>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 01:39:48PM +0100, Helge Hafting wrote:
> They can always claim that reverse engineering works both ways.
> Linux spinlocks can be reverse engineered, or they can search
> the mailing list archives for detailed explanations. :-/

Sure they can do that.  But the point is they don't.  Every propritary driver
so far uses the linux spinlock inline routines directly, may it be in the
object or in the glue code they ship.

