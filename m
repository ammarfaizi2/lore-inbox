Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267652AbUIFIwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267652AbUIFIwY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 04:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267668AbUIFIwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 04:52:24 -0400
Received: from ozlabs.org ([203.10.76.45]:36320 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267652AbUIFIwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 04:52:21 -0400
Date: Mon, 6 Sep 2004 18:51:08 +1000
From: Anton Blanchard <anton@samba.org>
To: John Levon <levon@movementarian.org>
Cc: akpm@osdl.org, phil.el@wanadoo.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix oprofile vfree warning on error
Message-ID: <20040906085108.GQ7716@krispykreme>
References: <20040904174403.GC7716@krispykreme> <20040904174642.GD7716@krispykreme> <20040905143201.GB79932@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040905143201.GB79932@compsoc.man.ac.uk>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Why does vfree() differ from free() / kfree() in not accepting NULL ?
> This seems like an interface wart.

No idea, it does seem wrong to have this difference between kfree and vfree.

Anton
