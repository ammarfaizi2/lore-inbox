Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267367AbUJRUtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267367AbUJRUtf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 16:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267312AbUJRUpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 16:45:32 -0400
Received: from mail1.kontent.de ([81.88.34.36]:41930 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S267301AbUJRUlp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 16:41:45 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Date: Mon, 18 Oct 2004 22:42:04 +0200
User-Agent: KMail/1.6.2
Cc: Gerd Knorr <kraxel@bytesex.org>, linux-fbdev-devel@lists.sourceforge.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       penguinppc-team@lists.penguinppc.org
References: <416E6ADC.3007.294DF20D@localhost> <20041018121033.GB5106@bytesex> <20041018202147.GA28720@hh.idb.hist.no>
In-Reply-To: <20041018202147.GA28720@hh.idb.hist.no>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200410182242.04749.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 18. Oktober 2004 22:21 schrieb Helge Hafting:
> > On first access only, and even that only if the driver doesn't map the
> > pages at mmap() time already.  Not a single fb driver seems to map the
> > pages lazy today, grepping in drivers/video for nopage handles shows
> > nothing.  I'm not sure you can actually do that for iomem mappings.
> > 
> Isn't it possible for the driver to unmap the mapping when
> suspending?  Then you're guaranteed to get that first access.

But what would you do then? Block everything that is using a terminal?

	Regards
		Oliver

