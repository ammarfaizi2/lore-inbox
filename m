Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268107AbTAJCVi>; Thu, 9 Jan 2003 21:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268108AbTAJCVi>; Thu, 9 Jan 2003 21:21:38 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:40710 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S268107AbTAJCVh>; Thu, 9 Jan 2003 21:21:37 -0500
Date: Fri, 10 Jan 2003 02:29:45 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Re: xxx_check_var
In-Reply-To: <Pine.GSO.4.21.0212221315451.11715-100000@vervain.sonytel.be>
Message-ID: <Pine.LNX.4.44.0301100229090.18287-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > Yes, this wrong, and afaik, it's your original port to 2.5 that did that
> > > ;)
> > 
> > Yeap. The idea of check_var is to validate a mode. Note modedb uses just
> > check_var. It is okay to READ the values in your par. You shouldn't alter
> > the values in par.
> 
> Perhaps it makes sense to make the info parameter of fb_check_var() const to
> prevent this from happening?

Easy fix. I can whip up a quick patch for that.

