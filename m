Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316756AbSE3QqJ>; Thu, 30 May 2002 12:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316757AbSE3QqI>; Thu, 30 May 2002 12:46:08 -0400
Received: from c16443.eburwd3.vic.optusnet.com.au ([210.49.192.62]:45553 "EHLO
	kira.glasswings.com.au") by vger.kernel.org with ESMTP
	id <S316756AbSE3QqI>; Thu, 30 May 2002 12:46:08 -0400
Date: Fri, 31 May 2002 02:50:31 +1000
From: Andrew Pam <xanni@glasswings.com.au>
To: Hannu Mallat <hmallat@cc.hut.fi>, James Simmons <jsimmons@linux-fbdev.org>,
        James Simmons <jsimmons@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: 3dfx framebuffer driver borked in 2.5.19 kernel
Message-ID: <20020530165031.GA18544@kira.glasswings.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The tdfxfb.c framebuffer driver works perfectly for me (apart from the
known problem with the wrong palette for the boot penguin in 16/32bps
colour depth since around kernel 2.4.6) in every kernel version up to and
including 2.5.18.  With the port to the new fbdev interface in kernel
2.5.19 the system now only displays a few unchanging coloured pixels
on the first line of the screen.  The rest of the screen remains black
until X11 starts.  I am using append="video=tdfx:1024x768" in LILO.

Regards,
	Andrew Pam
-- 
mailto:xanni@xanadu.net                         Andrew Pam
http://www.xanadu.com.au/                       Chief Scientist, Xanadu
http://www.glasswings.com.au/                   Technology Manager, Glass Wings
http://www.sericyb.com.au/                      Manager, Serious Cybernetics
http://two-cents-worth.com/?105347&EG		Donate two cents to our work!
P.O. Box 477, Blackburn VIC 3130 Australia	Phone +61 401 258 915
