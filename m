Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262948AbTCKPVv>; Tue, 11 Mar 2003 10:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262950AbTCKPVu>; Tue, 11 Mar 2003 10:21:50 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:53007 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262948AbTCKPVp>; Tue, 11 Mar 2003 10:21:45 -0500
Date: Tue, 11 Mar 2003 15:31:55 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: Antonino Daplas <adaplas@pol.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Re: FBdev updates.
In-Reply-To: <20030309212903.GC16578@vana.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44.0303111527500.23668-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi James,
>   I tried to use fb_cursor and I have quite a lot problems with
> it:

I'm working on the code today. I just finished the final touchs on the 
pixmap buffer code. The next step is to make the pixmaps have flag for 
static data versus dynamic data. You can then use fastfonst with static 
buffer. This comes with the tile code. But first the cursor code today.

P.S
  You can grab my latest work on the matroxfb driver at 

http://phoenix.infradead.org/~jsimmons/matroxfb.diff.gz





