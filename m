Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265570AbTAHKoJ>; Wed, 8 Jan 2003 05:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265633AbTAHKoJ>; Wed, 8 Jan 2003 05:44:09 -0500
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:23286 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S265570AbTAHKoI>; Wed, 8 Jan 2003 05:44:08 -0500
Date: Wed, 8 Jan 2003 11:48:17 +0100
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: rotation.
Message-ID: <20030108104817.GA10165@iliana>
References: <Pine.LNX.4.44.0301072240530.17129-100000@phoenix.infradead.org> <Pine.GSO.4.21.0301081120540.21171-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0301081120540.21171-100000@vervain.sonytel.be>
User-Agent: Mutt/1.4i
From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2003 at 11:24:22AM +0100, Geert Uytterhoeven wrote:
> On Tue, 7 Jan 2003, James Simmons wrote:
> > I'm about to implement rotation which is needed for devices like the ipaq. 
> > The question is do we flip the xres and yres values depending on the 
> > rotation or do we just alter the data that will be drawn to make the 
> > screen appear to rotate. How does hardware rotate view the x and y axis?
> > Are they rotated or does just the data get rotated? 
> 
> Where are you going to implement the rotation? At the fbcon or fbdev level?
> 
> Fbcon has the advantage that it'll work for all frame buffer devices.

But you could also provide driver hooks for the chips which have such a
rotation feature included (don't know if such exist, but i suppose they
do, or may in the future).

So, we also support fbcon for not left to righ locales ?

Friendly,

Sven Luther
