Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbTDCRH7 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 12:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S261404AbTDCRHZ 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 12:07:25 -0500
Received: from smtp4.wanadoo.fr ([193.252.22.28]:39200 "EHLO
	mwinf0301.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261412AbTDCRHB 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 12:07:01 -0500
Date: Thu, 3 Apr 2003 19:18:20 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sven Luther <luther@dpt-info.u-strasbg.fr>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH]: EDID parser
Message-ID: <20030403171820.GE1092@iliana>
References: <1049383273.11742.0.camel@dhcp22.swansea.linux.org.uk> <Pine.GSO.4.21.0304031831030.23642-100000@vervain.sonytel.be> <20030403171009.GC1092@iliana> <1049386531.11747.32.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049386531.11747.32.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 05:15:32PM +0100, Alan Cox wrote:
> On Iau, 2003-04-03 at 18:10, Sven Luther wrote:
> > It has two outputs, where i can hook either a DVI or a VGA monitor. Each
> > of these video outputs correspond to a viewport, and there is hardware
> > which will let you set the output timings and the dot clock. You also
> > have to configure which part of the framebuffer you are reading, and
> > eventually setup a scaller to scale the pixels you read to the correct
> > output buffer. You also have for each head a DDC/I2C bus you can use to
> > speak with the monitor.
> 
> Very common except lower end stuff generally has a single frame buffer
> that both show and cannot be split or scanned by multiple outputs at
> different rates.

So, using the terminology of Petr's graph, you have only one CRTC, with
two possible outputs, or maybe you have two CRTC but which needs to be
synchronized between them ?

Friendly,

Sven Luther
