Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316578AbSH0RJJ>; Tue, 27 Aug 2002 13:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316582AbSH0RJJ>; Tue, 27 Aug 2002 13:09:09 -0400
Received: from bs1.dnx.de ([213.252.143.130]:4531 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S316578AbSH0RJI>;
	Tue, 27 Aug 2002 13:09:08 -0400
Date: Tue, 27 Aug 2002 19:13:23 +0200
From: Robert Schwebel <robert@schwebel.de>
To: "Daniel I. Applebaum" <kernel@danapple.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1[89] boot problem
Message-ID: <20020827171323.GP6981@pengutronix.de>
References: <20020823060716.020F1107D9@wotke.danapple.com> <20020827130810.1A04F111F0@wotke.danapple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20020827130810.1A04F111F0@wotke.danapple.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 08:08:05AM -0500, Daniel I. Applebaum wrote:
> I've been tracking down my booting problem, and while reviewing old
> email, found that in trying to track down (and never succeeding) a VM
> problem last fall, I determined that any kernel after 2.4.15-pre2
> would not boot on my machine.  So, something changed between
> 2.4.15-pre2 and 2.4.15-pre3 that means linux will not boot.  The
> symptom is that the boot sequence displays "Loading linux-2.4.19..."
> but never display "Uncompressing".  I've enclosed the 2.4.15-pre3
> Changelog.  Any ideas which of the changes would have affected
> booting?

I missed the original post - on which plattform do you want to run your
kernel? I had similar problems with versions around that time and it
turned out that it came from a change in the A19 initialisation code in
combination with some BIOSes. A fix for the AMD Elan family went into
2.4.18, but it may affect others as well. 

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Braunschweiger Str. 79,  31134 Hildesheim, Germany
    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4
