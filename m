Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbUC1DSY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 22:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUC1DSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 22:18:24 -0500
Received: from mxsf16.cluster1.charter.net ([209.225.28.216]:272 "EHLO
	mxsf16.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S262070AbUC1DSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 22:18:18 -0500
Subject: Re: 2.6.5-rc2-mm[34] causes drop in DRI FPS
From: Glenn Johnson <glennpj@charter.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040327180932.10e4bae7.akpm@osdl.org>
References: <1080435375.8280.1.camel@gforce.johnson.home>
	 <20040327180932.10e4bae7.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1080443802.7085.2.camel@gforce.johnson.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 27 Mar 2004 21:16:42 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-03-27 at 20:09, Andrew Morton wrote: 
> Glenn Johnson <glennpj@charter.net> wrote:
> >
> > The last two iterations of -mm kernels have caused my FPS count via
> > glxgears to drop from about 2000 fps to about 180 fps. I rebuilt X11 to
> > see if that would help but it did not.
> > 
> > This is with a Radeon 9100 AGP card and an Intel 865PE based
> > motherboard.
> 
> It could be the AGP changes.  Please do a `patch -p1 -R' of
> bk-agpgart.patch and retest?

I reverted that patch and retested but it did not solve the problem. I
am still only seeing about 180 fps with glxgears.

