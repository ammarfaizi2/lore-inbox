Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbVCYSr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbVCYSr1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 13:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbVCYSr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 13:47:27 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:33430 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261726AbVCYSrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 13:47:21 -0500
Date: Fri, 25 Mar 2005 18:47:18 +0000
From: Christoph Hellwig <hch@infradead.org>
To: James Bottomley <jejb@steeleye.com>
Cc: Bruno Cornec <Bruno.Cornec@hp.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, tvignaud@mandrakesoft.com
Subject: Re: megaraid driver (proposed patch)
Message-ID: <20050325184718.GA15215@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Bottomley <jejb@steeleye.com>,
	Bruno Cornec <Bruno.Cornec@hp.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	tvignaud@mandrakesoft.com
References: <20050325182252.GA4268@morley.grenoble.hp.com> <1111775992.5692.25.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111775992.5692.25.camel@mulgrave>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2005 at 12:39:52PM -0600, James Bottomley wrote:
> On Fri, 2005-03-25 at 19:22 +0100, Bruno Cornec wrote:
> > Would you consider to apply the following patch proposed by Thierry
> > Vignaud as a solution for the MandrakeSoft kernel in the mainstream 2.6 
> > kernel ?
> 
> Well, to be considered you'd need to cc the megaraid maintainers and the
> linux-scsi mailing list.
> 
> > -if MEGARAID_NEWGEN=n
> 
> No, this is wrong it would break allyes configs and I'd get shot.

Why?  The megaraid drivers shouldn't have any conflicting non-static
symbols

