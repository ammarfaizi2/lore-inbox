Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261952AbTCTUXO>; Thu, 20 Mar 2003 15:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262045AbTCTUXN>; Thu, 20 Mar 2003 15:23:13 -0500
Received: from havoc.daloft.com ([64.213.145.173]:8918 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S261952AbTCTUXM>;
	Thu, 20 Mar 2003 15:23:12 -0500
Date: Thu, 20 Mar 2003 15:34:07 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: Release of 2.4.21
Message-ID: <20030320203407.GF8256@gtf.org>
References: <20030320195657.GA3270@drcomp.erfurt.thur.de> <874r5xyeky.fsf@sdbk.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874r5xyeky.fsf@sdbk.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 09:21:01PM +0100, Sebastian D.B. Krause wrote:
> On 3487 September 1993, Adrian Knoth wrote:
> > how about releasing 2.4.21 with the ptrace()-fix applied immediately
> > like it has been done with 2.2.25?
> >
> > I think it's a serious bug and therefore it's time for a security-update.
> 
> I think the best way is to release a 2.4.21 kernel with only the
> most important fixes (e.g. ptrace, ext3) and no new features. All
> new featues which need more testing and are now in 2.4.21-pre could
> then go to 2.4.22-pre for more testing (as Alan did with

Something vaguely like this has been suggested, which I think is a good
idea:

For critical fixes, release a 2.4.20.1, 2.4.20.2, etc.  Don't disrupt
the 2.4.21-pre cycle, that would be less productive than just patching
2.4.20 and rolling a separate release off of that.

	Jeff



