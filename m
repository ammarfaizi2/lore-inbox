Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266203AbTAHLRN>; Wed, 8 Jan 2003 06:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266295AbTAHLRN>; Wed, 8 Jan 2003 06:17:13 -0500
Received: from elixir.e.kth.se ([130.237.48.5]:2311 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S266203AbTAHLRM>;
	Wed, 8 Jan 2003 06:17:12 -0500
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: rotation.
References: <Pine.LNX.4.44.0301072240530.17129-100000@phoenix.infradead.org>
	<Pine.GSO.4.21.0301081120540.21171-100000@vervain.sonytel.be>
	<20030108104817.GA10165@iliana>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 08 Jan 2003 12:25:18 +0100
In-Reply-To: Sven Luther's message of "Wed, 8 Jan 2003 11:48:17 +0100"
Message-ID: <yw1xu1gj51ep.fsf@tiptop.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Luther <luther@dpt-info.u-strasbg.fr> writes:

> > > I'm about to implement rotation which is needed for devices like the ipaq. 
> > > The question is do we flip the xres and yres values depending on the 
> > > rotation or do we just alter the data that will be drawn to make the 
> > > screen appear to rotate. How does hardware rotate view the x and y axis?
> > > Are they rotated or does just the data get rotated? 
> > 
> > Where are you going to implement the rotation? At the fbcon or fbdev level?
> > 
> > Fbcon has the advantage that it'll work for all frame buffer devices.
> 
> But you could also provide driver hooks for the chips which have such a
> rotation feature included (don't know if such exist, but i suppose they
> do, or may in the future).

I heard of someone have problems with the display getting rotated in
Windows.  I don't know what chip it was.

-- 
Måns Rullgård
mru@users.sf.net
