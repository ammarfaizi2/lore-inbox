Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262369AbSJOLOV>; Tue, 15 Oct 2002 07:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262382AbSJOLOV>; Tue, 15 Oct 2002 07:14:21 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:21888 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262369AbSJOLOU>;
	Tue, 15 Oct 2002 07:14:20 -0400
Date: Tue, 15 Oct 2002 12:20:58 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, Rob Radez <rob@osinvestor.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Russell King <rmk@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Watchdog drivers
Message-ID: <20021015112058.GA8973@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	David Woodhouse <dwmw2@infradead.org>,
	Wim Van Sebroeck <wim@iguana.be>, Rob Radez <rob@osinvestor.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
References: <20021014130441.GA528@suse.de> <20021013234308.P23142@flint.arm.linux.org.uk> <Pine.LNX.4.33L2.0210131615480.22520-100000@dragon.pdx.osdl.net> <20021013215726.P16698@osinvestor.com> <20021014101209.A18123@medelec.uia.ac.be> <20021014122239.GA29240@suse.de> <20021014144158.A19209@medelec.uia.ac.be> <15236.1034674538@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15236.1034674538@passion.cambridge.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 10:35:38AM +0100, David Woodhouse wrote:
 > 
 > davej@codemonkey.org.uk said:
 > >  They remain character devices, so drivers/char/watchdog/  gets my
 > > vote. Any nay-sayers ? 
 > 
 > By that logic, we should have only drivers/{net,char,block}.

Suits me 8-)
Though a drivers/bus/ would make sense too for things like pci, sbus, 
and friends, but that kind of thing can wait until 2.7 I think 8-)
To get back to the point, drivers/ seems cluttered, and as the
objective is decluttering drivers/char/ removing a dozen files, and
replacing them with a single directory in that dir just seems better
than adding an extra dir in drivers/ to me, but then again, I could
be out of my tiny little mind.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
