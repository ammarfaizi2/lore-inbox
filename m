Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbUKUEx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbUKUEx4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 23:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263208AbUKUEx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 23:53:56 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:17143 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261798AbUKUExy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 23:53:54 -0500
Date: Sat, 20 Nov 2004 21:55:39 -0700
From: Jesse Allen <the3dfxdude@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>, Daniel Jacobowitz <dan@debian.org>,
       Eric Pouech <pouech-eric@wanadoo.fr>,
       Roland McGrath <roland@redhat.com>, Mike Hearn <mh@codeweavers.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
Message-ID: <20041121045539.GA4318@tesore.ph.cox.net>
Mail-Followup-To: Jesse Allen <the3dfxdude@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Daniel Jacobowitz <dan@debian.org>,
	Eric Pouech <pouech-eric@wanadoo.fr>,
	Roland McGrath <roland@redhat.com>, Mike Hearn <mh@codeweavers.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	wine-devel <wine-devel@winehq.com>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com> <419E42B3.8070901@wanadoo.fr> <Pine.LNX.4.58.0411191119320.2222@ppc970.osdl.org> <419E4A76.8020909@wanadoo.fr> <Pine.LNX.4.58.0411191148480.2222@ppc970.osdl.org> <419E5A88.1050701@wanadoo.fr> <20041119212327.GA8121@nevyn.them.org> <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org> <20041120214915.GA6100@tesore.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041120214915.GA6100@tesore.ph.cox.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2004 at 02:49:15PM -0700, Jesse Allen wrote:
> the interesting part in a seperate file:
> ftp://resnet.dnip.net/
> 

I took another look at the section I found.  It doesn't describe much, but it
shows "000c: *signal* signal=5" for example, which are probably SIGTRAP's.

I decided to capture a log running under a kernel before the change, and see 
if I could find the same section again, based on the mutex name.  Well I did, 
and found alot more tracing.  The thread 000c didn't get killed either so it
shows something is different.  Of course under the old kernels I don't get the
"insert disc" message.  I put up the working version log on the ftp.


Jesse

