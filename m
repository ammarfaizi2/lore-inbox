Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262222AbVC2I4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbVC2I4o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 03:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbVC2I4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 03:56:31 -0500
Received: from sd291.sivit.org ([194.146.225.122]:8196 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262222AbVC2IxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 03:53:04 -0500
Date: Tue, 29 Mar 2005 10:52:58 +0200
From: Luc Saillard <luc@saillard.org>
To: Norbert Preining <preining@logic.at>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pwc driver in -mm kernels
Message-ID: <20050329085257.GA18799@sd291.sivit.org>
References: <20050319130424.GB3316@gamma.logic.tuwien.ac.at> <1111416966.14877.26.camel@localhost.localdomain> <20050321150954.GD14614@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050321150954.GD14614@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 04:09:54PM +0100, Norbert Preining wrote:
> On Mon, 21 Mär 2005, Alan Cox wrote:
> > I pushed the tested one as a starting point. May have been the wrong
> > decision but it's my fault if so
> 
> Ah ok. I checked the differences between the versions but there are too
> many `none-standard' changes, i.e. kernel-language changes (statics,
> inlines, __) etc so that I cannot submit a patch for the new version.
> 
> The good thing about the one on Luc's page it that it includes sysfs
> support for several parameters and some more device ids.

Sorry, i was in holliday far far away from my computer (it's very rare).
I can produce a patch with coding style fixes, or wait to fix a bug in v4l2
then submit the patch. What do you prefer ? Some applications crashes when
using the v4l2 API. I can made v4l2 optional.

I know that a lot of changes needs to be applied to the driver to please
everybody. So perhaps i can try to begin with a patch (with v4l2), and wait
for feedback, and resend patch until this is correct ?

Luc
