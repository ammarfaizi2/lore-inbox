Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbULTCmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbULTCmT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 21:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbULTCmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 21:42:19 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:11728 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261397AbULTCmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 21:42:16 -0500
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
From: Lee Revell <rlrevell@joe-job.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Dan Dennedy <dan@dennedy.org>, Ben Collins <bcollins@debian.org>,
       Linux1394-Devel <linux1394-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041220022503.GT21288@stusta.de>
References: <20041220015320.GO21288@stusta.de>
	 <1103508610.3724.69.camel@kino.dennedy.org>
	 <20041220022503.GT21288@stusta.de>
Content-Type: text/plain
Date: Sun, 19 Dec 2004 21:42:14 -0500
Message-Id: <1103510535.1252.18.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-20 at 03:25 +0100, Adrian Bunk wrote:
> On Sun, Dec 19, 2004 at 09:10:10PM -0500, Dan Dennedy wrote:
> > On Mon, 2004-12-20 at 02:53 +0100, Adrian Bunk wrote:
> > > The patch below removes 41 unneeded EXPORT_SYMBOL's.
> > 
> > Unneeded according to whom, just you? These functions are part of an
> > API. How do I know someone is not using these in a custom ieee1394
> > kernel module in some industrial or research setting or something new
> > under development to be contributed to linux1394 project?
> 
> If someone uses some of them in code to be contributed to the linux1394 
> project, re-adding the EXPORT_SYMBOL's in question is trivial.
> 
> If someone uses some of them in a custom setting, re-adding them is 
> trivial, too.
> 
> If the only user of one or more of these EXPORT_SYMBOL's was a non-free 
> module, it's kernel policy that the EXPORT_SYMBOL's in question have to 
> be removed.

What do you tell a vendor who wants to write a driver for their device?
"OK, about half the functions you need are in the kernel, the other half
you have to port from this old kernel because we removed them.  Maybe we
will put them back if we really like your driver"?

Lee

