Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751893AbWAOKEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbWAOKEd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 05:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbWAOKEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 05:04:33 -0500
Received: from deine-taler.de ([217.160.107.63]:55224 "EHLO
	p15091797.pureserver.info") by vger.kernel.org with ESMTP
	id S1751890AbWAOKEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 05:04:32 -0500
Date: Sun, 15 Jan 2006 11:04:05 +0100 (CET)
From: Ulrich Kunitz <kune@deine-taler.de>
To: Pete Zaitcev <zaitcev@redhat.com>
cc: Ulrich Kunitz <kune@deine-taler.de>, linville@tuxdriver.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dsd@gentoo.org
Subject: Re: wireless: recap of current issues (stack)
In-Reply-To: <20060114204211.72942d45.zaitcev@redhat.com>
Message-ID: <Pine.LNX.4.58.0601151056140.31304@p15091797.pureserver.info>
References: <20060113195723.GB16166@tuxdriver.com> <20060113212605.GD16166@tuxdriver.com>
 <20060113213200.GG16166@tuxdriver.com> <Pine.LNX.4.58.0601141448480.5587@p15091797.pureserver.info>
 <20060114204211.72942d45.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Jan 2006, Pete Zaitcev wrote:

> On Sat, 14 Jan 2006 15:13:39 +0100 (CET), Ulrich Kunitz <kune@deine-taler.de> wrote:
> 
> > [...] Register accesses in USB devices should be
> > able to sleep. However the 80211 stacks I've seen so far have a
> > fixed set of capabilities and do also assume, that at the driver
> > layer everything can be done in atomic mode, which is only true
> > for buses that support memory-mapping.
> 
> If this problem is real, then it's serious. However, I'm not seeing it
> with prism54usb and Berg's softmac (yet?). Would you be so kind to provide
> the file name and function name for the code which makes these assumptions?
> 
> Thanks,
> -- Pete
> 

Pete,

I've been wrong.

I couldn't find the problem in the latest version of the
ieee80211softmac. Thank you for noticing me.

Uli

-- 
Ulrich Kunitz - kune@deine-taler.de
