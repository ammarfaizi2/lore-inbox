Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131407AbRDBWSu>; Mon, 2 Apr 2001 18:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131408AbRDBWSl>; Mon, 2 Apr 2001 18:18:41 -0400
Received: from snowstorm.mail.pipex.net ([158.43.192.97]:52975 "HELO
	snowstorm.mail.pipex.net") by vger.kernel.org with SMTP
	id <S131407AbRDBWSZ>; Mon, 2 Apr 2001 18:18:25 -0400
To: linux-kernel@vger.kernel.org
From: Trevor-Hemsley@dial.pipex.com (Trevor Hemsley)
Date: Mon, 02 Apr 2001 22:55:36
Subject: Re: Matrox G400 Dualhead
X-Mailer: ProNews/2 V1.51.ib103
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <20010402221831Z131407-407+5602@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Apr 2001 17:43:42, Petr Vandrovec <vandrove@vc.cvut.cz> 
wrote:

> Trevor Hemsley wrote:
> 
> > I get this as well on my G200. From observation it appears that the
> > refresh rate is being doubled when you exit X and that's why the
> > console appears blank. On my system I normally use
> > 
> > modprobe matroxfb vesa=263 fv=85
> > 
> > to give a large text console. On return from X, if I blindly type
> > 
> > fbset "640x480-60"
> > 
> > then I get a visible screen back but my monitor tells me that it's
> > running at 640x480@119Hz. Same thing for 800x600-60 only this one says
> > 120Hz.
> 
> Unfortunately Matrox datasheet says that it is impossible :-( Can you
> try 'fbset -depth 0; fbset -depth 8' ?

Yes, that fixes it. Issuing the first fbset command brings me back 
some sort of display, all fsck'ed up but vaguely readable with 
shimmering bits of text all over it in the wrong places. The second 
fbset gets it back correctly at the right resolution and right refresh
rate. Thanks, a workaround at least.

-- 
Trevor Hemsley, Brighton, UK.
Trevor-Hemsley@dial.pipex.com
