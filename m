Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265843AbSLSSAX>; Thu, 19 Dec 2002 13:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265828AbSLSSAX>; Thu, 19 Dec 2002 13:00:23 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:50692 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S265843AbSLSSAU>; Thu, 19 Dec 2002 13:00:20 -0500
Date: Thu, 19 Dec 2002 18:08:20 +0000
From: John Levon <levon@movementarian.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (4/5) improved notifier callback mechanism - read copy update
Message-ID: <20021219180820.GA41037@compsoc.man.ac.uk>
References: <1040249652.14364.192.camel@dell_ss3.pdx.osdl.net> <20021219181929.A5265@in.ibm.com> <1040319430.23567.15.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1040319430.23567.15.camel@dell_ss3.pdx.osdl.net>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18P55p-000PNb-00*HsWCVFONcxs*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2002 at 09:37:10AM -0800, Stephen Hemminger wrote:

> Thanks, will look into it in more detail. Perhaps figuring out how to do
> oprofile without sleeping would be best.

You can try, but I don't think you'll get far ... maintaining the
necessary "no samples present for exited process" invariant is difficult
without sleeping.

It would seem better just to force the profiling hooks to use a
different API

regards
john

-- 
"ALL television is children's television."
	- Richard Adler 
