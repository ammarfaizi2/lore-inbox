Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271901AbTG2RJu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 13:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271895AbTG2RJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 13:09:49 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:30469 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271938AbTG2RJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 13:09:15 -0400
Date: Tue, 29 Jul 2003 18:09:04 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: neofb problems with 2.6.0-test1-ac3 etc. -- kernel-2.6.x ignoramus
In-Reply-To: <20030726124907.GB22804@charite.de>
Message-ID: <Pine.LNX.4.44.0307291807490.5874-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This is my framebuffer. It works, but switching back and forth between
> X11 and the fbconsole totally trashes the framebuffer. 
> 
> fbset -depth 16
> 
> fixes things again. To see what I see, look at:
> http://sbserv.stahl.bau.tu-bs.de/~hildeb/fbfubar/

This is because the X server is not fbdev aware. Try adding the UseFBDev 
option in your XF86Config. That shoudl fix your problems.


