Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262987AbVGNJpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262987AbVGNJpx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 05:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262989AbVGNJpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 05:45:53 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:62080 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262987AbVGNJpv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 05:45:51 -0400
Date: Thu, 14 Jul 2005 11:48:23 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Message-ID: <20050714094823.GB3399@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200507131733_MC3-1-A464-F432@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507131733_MC3-1-A464-F432@compuserve.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: 84.189.241.250
Subject: Re: 2.6.13-rc2-mm2
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2005 at 05:29:32PM -0400, Chuck Ebbert wrote:
> On Wed, 13 Jul 2005 at 00:23:42 -0700, Andrew Morton wrote:
> 
> >>    ...and BTW why does every line in the series file have a trailing space?
> >
> > Not in my copy of
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc2/2.6.13-rc2-mm2/patch-series
> > ?
> 
> 
>   Looks like Quilt is adding the space during push/pop operations.  Only the
> lines it has touched in the series file have the trailing space.

Nope. For me quilt leaves a trailing space if I add patches with -p0
to the series file and then do a "quilt refresh -p1".

Johannes
