Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261708AbSJAP0J>; Tue, 1 Oct 2002 11:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261707AbSJAP0J>; Tue, 1 Oct 2002 11:26:09 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:17540 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261852AbSJAP0I>;
	Tue, 1 Oct 2002 11:26:08 -0400
Date: Tue, 1 Oct 2002 16:34:54 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: jlnance@intrex.net
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: Linux v2.5.40 - and a feature freeze reminder
Message-ID: <20021001153454.GC126@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>, jlnance@intrex.net,
	linux-kernel@vger.kernel.org, vojtech@suse.cz
References: <Pine.LNX.4.33.0210010021400.25527-100000@penguin.transmeta.com> <20021001122504.GC3234@tricia.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021001122504.GC3234@tricia.dyndns.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 08:25:04AM -0400, jlnance@intrex.net wrote:

 > Do the ps/2 mouse and the keyboard work like they did in 2.4 (same /dev
 > major/minor)?  I tried 2.5 early on but quit because I couldnt see my
 > input devices.  At the time I posted a note and got some responses, but
 > it appeared that I would have to change things around such that they
 > wouldnt work with 2.4 anymore, which I was not willing to do.

There are several new CONFIG_ options you need to configure to get
keyboard/mouse working in 2.5. Asides from this, everything has
'just worked' for me.  There are some keyboards out there that are
still having slight problems, but Vojtech is working his way through
these.

If anyone is still having "keyboard/mouse doesn't work" problems in 2.5
after enabling the relevant CONFIG_ options, enable the DEBUG defines
in i8042.c, and let Vojtech (vojtech@suse.cz) know about it.

The biggest problems (all?) in this area should be long gone now.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
