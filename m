Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVE1RXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVE1RXB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 13:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVE1RXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 13:23:01 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:49621 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261170AbVE1RXA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 13:23:00 -0400
X-ORBL: [63.202.173.158]
Date: Sat, 28 May 2005 10:22:26 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, akpm@osdl.org,
       jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, mingo@redhat.com
Subject: Re: [patch 1/1] [RFC] uml: add and use generic hw_controller_type->release
Message-ID: <f17872eaacd075b18c8af457590839dc.IBX@taniwha.stupidest.org>
References: <20050527003926.1FD861AEE92@zion.home.lan> <c915b004e775ff68517f3be2c95c6f93.IBX@taniwha.stupidest.org> <200505281326.15519.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505281326.15519.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2005 at 01:26:15PM +0200, Blaisorblade wrote:

> Well, that's a point, even because a conditional jump needs to flush
> the pipeline when mispredicted (which won't happen on other ARCHs
> after the initial period, if this jump stays in the Branch Target
> Buffers).

Because it's crud we are accumulating over time that nobody except UML
needs and maybe one day UML won't need it.  Also #ifdef's (though
ugly) would make it much more likely that it goes away when it can.
