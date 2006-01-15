Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWAOEmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWAOEmf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 23:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWAOEme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 23:42:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37071 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751102AbWAOEmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 23:42:33 -0500
Date: Sat, 14 Jan 2006 20:42:11 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Ulrich Kunitz <kune@deine-taler.de>
Cc: linville@tuxdriver.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, zaitcev@redhat.com, <dsd@gentoo.org>
Subject: Re: wireless: recap of current issues (stack)
Message-Id: <20060114204211.72942d45.zaitcev@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0601141448480.5587@p15091797.pureserver.info>
References: <20060113195723.GB16166@tuxdriver.com>
	<20060113212605.GD16166@tuxdriver.com>
	<20060113213200.GG16166@tuxdriver.com>
	<Pine.LNX.4.58.0601141448480.5587@p15091797.pureserver.info>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Jan 2006 15:13:39 +0100 (CET), Ulrich Kunitz <kune@deine-taler.de> wrote:

> [...] Register accesses in USB devices should be
> able to sleep. However the 80211 stacks I've seen so far have a
> fixed set of capabilities and do also assume, that at the driver
> layer everything can be done in atomic mode, which is only true
> for buses that support memory-mapping.

If this problem is real, then it's serious. However, I'm not seeing it
with prism54usb and Berg's softmac (yet?). Would you be so kind to provide
the file name and function name for the code which makes these assumptions?

Thanks,
-- Pete
