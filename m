Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbVKNDcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbVKNDcb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 22:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbVKNDcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 22:32:31 -0500
Received: from hera.kernel.org ([140.211.167.34]:8679 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750856AbVKNDca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 22:32:30 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] vgacon: Workaround for resize bug in some chipsets
Date: Sun, 13 Nov 2005 19:32:08 -0800 (PST)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <dl90fo$nj2$1@terminus.zytor.com>
References: <58c2Z-8jG-23@gated-at.bofh.it> <4377BA19.2060600@gmail.com> <4377BD8A.9070404@kolumbus.fi> <4377CDD8.1000509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1131939128 24163 127.0.0.1 (14 Nov 2005 03:32:08 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 14 Nov 2005 03:32:08 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <4377CDD8.1000509@gmail.com>
By author:    "Antonino A. Daplas" <adaplas@gmail.com>
In newsgroup: linux.dev.kernel
> >>  
> >>
> > I think vgacon doesn't touch the 8/9 pixel setting, so  the fonts are hw
> > extended to 9 pixels by VGA in many modes.
> > 
> 
> It's not a hardware limitation, but vgacon is hardcoded to accept fonts that are
> only 8 pixels wide.  You can try it by doing a setfont.
> 

The *font* is always 8 pixels wide.  Whether or not you display it in
8- or 9-pixel mode is irrelevant to the formatting of the font.

In general, for vgacon, it should use the 9-pixel mode, at least by default.

	-hpa
