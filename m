Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130487AbRDMMyI>; Fri, 13 Apr 2001 08:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130493AbRDMMx6>; Fri, 13 Apr 2001 08:53:58 -0400
Received: from ns.caldera.de ([212.34.180.1]:37383 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S130487AbRDMMxs>;
	Fri, 13 Apr 2001 08:53:48 -0400
Date: Fri, 13 Apr 2001 14:52:49 +0200
From: Christoph Hellwig <hch@ns.caldera.de>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Wayne.Brown@altec.com, linux-kernel@vger.kernel.org
Subject: Re: badly punctuated parameter list in `#define' (2.4.3-ac5 and 2.4.4 -pre2)
Message-ID: <20010413145249.A29264@caldera.de>
Mail-Followup-To: Jamie Lokier <lk@tantalophile.demon.co.uk>,
	Wayne.Brown@altec.com, linux-kernel@vger.kernel.org
In-Reply-To: <86256A2C.0068BA0C.00@smtpnotes.altec.com> <200104121931.VAA02438@ns.caldera.de> <20010413123939.B30971@pcep-jamie.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <20010413123939.B30971@pcep-jamie.cern.ch>; from lk@tantalophile.demon.co.uk on Fri, Apr 13, 2001 at 12:39:39PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2001 at 12:39:39PM +0200, Jamie Lokier wrote:
> Christoph Hellwig wrote:
> > So the /* old gcc */ part should probably be enabled based on a define for the
> > old compiler.  The right ifdef seems to be:
> > 
> >   #if __GNUC__ == 2 && __GNUC_MINOR__ < 95
> 
> The current GCC supports the old syntax and will do so for a while yet,
> so perhaps this is not required?

If that's true (I have no gcc3.0 to verify it) that's the better soloution
in my eyes.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
