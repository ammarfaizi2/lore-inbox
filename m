Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262144AbVBUV7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbVBUV7l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 16:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbVBUV7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 16:59:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12995 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262144AbVBUV7k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 16:59:40 -0500
Date: Mon, 21 Feb 2005 14:08:13 -0500
From: Bill Nottingham <notting@redhat.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       fbdev <linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: Hotplug blacklist and video devices
Message-ID: <20050221190812.GA30832@nostromo.devel.redhat.com>
Mail-Followup-To: Jon Smirl <jonsmirl@gmail.com>,
	lkml <linux-kernel@vger.kernel.org>,
	fbdev <linux-fbdev-devel@lists.sourceforge.net>
References: <9e4733910502181251ea2b95e@mail.gmail.com> <20050218210822.GB8588@nostromo.devel.redhat.com> <9e47339105021813146cf69759@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e47339105021813146cf69759@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl (jonsmirl@gmail.com) said: 
> Is there a specific reason why they are blocked? 
> 
> For example I'm looking at making changes to DRM such that DRM will
> require the corresponding framebuffer driver to be loaded. If you back
> up further this is part of fixing X so that it won't mess with the
> hardware from user space. Mode setting would come from the framebuffer
> driver instead of the X 2D XAA driver.

If it's a hard module dep, I don't see how that would be a problem;
that would ignore the blacklist.

Bill
