Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267403AbTBUAuj>; Thu, 20 Feb 2003 19:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267405AbTBUAuj>; Thu, 20 Feb 2003 19:50:39 -0500
Received: from rth.ninka.net ([216.101.162.244]:62631 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S267403AbTBUAui>;
	Thu, 20 Feb 2003 19:50:38 -0500
Subject: Re: FBdev updates.
From: "David S. Miller" <davem@redhat.com>
To: James Simmons <jsimmons@infradead.org>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0302201951270.20350-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0302201951270.20350-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Feb 2003 17:45:00 -0800
Message-Id: <1045791900.21577.5.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-20 at 11:58, James Simmons wrote:
> > (3) persuade me that I want to write matroxcon and forget about fbcon at all, or
> 
> This is the best solution. 

And then we will have sbuscon as well, thus two places where
putcs() is necessary.

I don't understand, but I do hope that at some point it will be
realized that maybe allowing fbcon to generically handle putcs()
hardware is beneficial.

I can dream. :-)

