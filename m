Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266663AbUHSQbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266663AbUHSQbb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 12:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266679AbUHSQbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 12:31:31 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:44561 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S266663AbUHSQbZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 12:31:25 -0400
Date: Thu, 19 Aug 2004 17:31:24 +0100
From: John Levon <levon@movementarian.org>
To: Corey Minyard <minyard@acm.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Patch to 2.6.8.1-mm2 to allow multiple NMI handlers to be registered
Message-ID: <20040819163124.GA81535@compsoc.man.ac.uk>
References: <4124BACB.30100@acm.org> <16676.51035.924323.992044@alkaid.it.uu.se> <4124D25C.20703@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4124D25C.20703@acm.org>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1Bxpoy-000Q0X-KI*dKf90qHqSdo*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 11:16:28AM -0500, Corey Minyard wrote:

> >Please use rdpmc() instead of rdmsr() when reading counter registers.
> >Ditto in the other places.
> >(I know oprofile doesn't, but that's no excuse.)

I actually have no idea why we don't use rdpmc().

john
