Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261337AbTAaO7d>; Fri, 31 Jan 2003 09:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261356AbTAaO7d>; Fri, 31 Jan 2003 09:59:33 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:35034 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261337AbTAaO7c>;
	Fri, 31 Jan 2003 09:59:32 -0500
Date: Fri, 31 Jan 2003 15:05:41 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.59 morse code panics
Message-ID: <20030131150541.GA15332@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
References: <20030131104326.GF12286@louise.pinerecords.com> <200301311112.h0VBCv00000575@darkstar.example.net> <20030131132221.GA12834@codemonkey.org.uk> <200301311440.h0VEeRlH005883@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301311440.h0VEeRlH005883@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2003 at 09:40:27AM -0500, Valdis.Kletnieks@vt.edu wrote:

 > I have to do most of my kernel hacking at home, on my own time.  So I'm
 > sitting there with a laptop and no second machine.  Now, if the intent is
 > to say "Don't bother doing anything that might require debugging unless you
 > can afford 2 machines", that's OK - but let's be open about that requirement.
 > And has been pointed out, some laptops don't even *HAVE* a serial port.

So go see Ingo's netconsole. (Which admittedly only supports certain
net drivers). Or one of the crashdump facilities. All of which is far more
reliable and useful than sitting there with a microphone.
 
 > There's a *REASON* that IBM RS/6K boxes have at least a little 3-digit LED
 > display - during boot or a panic, even if you can't trust the console drivers
 > anymore, you can still output *something*.

There's no reason to trust morse panic output more than console output.
If something has scribbled over kernel space memory, you're screwed
anyway. It's hit or miss whether your panic-method-de-jour has been
stomped on.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
