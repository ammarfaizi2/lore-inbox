Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266008AbUAEXvT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 18:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266045AbUAEXr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 18:47:58 -0500
Received: from 202.46.136.55.interact.com.au ([202.46.136.55]:54640 "EHLO
	gaston") by vger.kernel.org with ESMTP id S266034AbUAEXpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 18:45:38 -0500
Subject: Re: 2.6.0: atyfb broken
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: James Simmons <jsimmons@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, claas@rootdir.de,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0401052333390.7347-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0401052333390.7347-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1073346254.9499.143.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 06 Jan 2004 10:44:14 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-06 at 10:33, James Simmons wrote:
> > > Ben, if you could shoot me over a copy of the current linux-fbdev tree that
> > > might help things along a bit.
> > 
> > linux-fbdev is at bk://fbdev.bkbits.net/fbdev-2.5
> > 
> > Some things in there are too crappy though, like the whole gfx-client
> > stuff, I suggest you don't merge as-is. I will start sending you
> > patches tomorrow hopefully.
> 
> Is the gfx-client stuff the only issue for 

The main one. I have some problems with the pixmap code (see my other
message about this, the locking is definitely broken) and I'm not sure
we want to merge the allocation changes upstream yet (well, maybe they
are stable enough by now ?)

Ben.
 
