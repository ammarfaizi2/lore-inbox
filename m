Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265238AbSLBVEk>; Mon, 2 Dec 2002 16:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265242AbSLBVEk>; Mon, 2 Dec 2002 16:04:40 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:33550 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265238AbSLBVEj>; Mon, 2 Dec 2002 16:04:39 -0500
Date: Mon, 2 Dec 2002 21:11:53 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Joseph Fannin <jhf@rivenstone.net>
cc: linux-kernel@vger.kernel.org, <linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Re: Fbdev 2.5.49 BK fixes.
In-Reply-To: <20021128083246.GA2703@zion.rivenstone.net>
Message-ID: <Pine.LNX.4.44.0212022110150.20834-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>     aty128fb works for me here with:
> 
> 01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF/PRO AGP 4x TMDS
> 
>     Thank you!

Great. I made more inprovements with my latest patch. Give it a try. 

>     There are a few glitches, but I've been unable to pin down
> anything serious as the fbdev patch's fault.  I'm still playing with
> things (like Antonio Daplas' patches).  I'll give a more full report
> later.

I just intergrated a bunch of his work. The subsystem is starting to 
really take shape. 

>     FWIW, the fbdev patch applies with a few minor offsets to 2.5.50
> except for the attached patch, which I extracted from bk.  So if you
> apply this patch in *reverse* to a clean 2.5.50 tree, the fbdev patch
> should then apply okay (patch complained about a reversed hunk in
> fbcon.c, but it should be harmless, I think.)

I noticed. My new patch fixes that.

