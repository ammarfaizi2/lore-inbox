Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263097AbSJGPh1>; Mon, 7 Oct 2002 11:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263119AbSJGPh0>; Mon, 7 Oct 2002 11:37:26 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:42390 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S263097AbSJGPhZ>; Mon, 7 Oct 2002 11:37:25 -0400
Date: Mon, 7 Oct 2002 11:43:03 -0400
To: Rob Landley <landley@trommello.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New BK License Problem?
Message-ID: <20021007154303.GB20941@ravel.coda.cs.cmu.edu>
Mail-Followup-To: Rob Landley <landley@trommello.org>,
	linux-kernel@vger.kernel.org
References: <20021006075627.I9032@work.bitmover.com> <Pine.LNX.4.44.0210061718370.9062-100000@localhost.localdomain> <20021006081514.J9032@work.bitmover.com> <200210070621.g976LV1H428754@pimout4-ext.prodigy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210070621.g976LV1H428754@pimout4-ext.prodigy.net>
User-Agent: Mutt/1.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2002 at 09:21:19PM -0400, Rob Landley wrote:
> It's possible that a version controlled filesystem will never be accepted 
> into the Linux tree just because Linus wouldn't want to give up bitkeeper.  
> Oh well.  Can't say I've ever personally had a need for one, and you could 
> always do it via Coda, assuming the existince of such a tool wouldn't taint 
> the Coda parts of the kernel... :)

Somebody already did, there is a backend somewhere that accesses RCS
archives as files through the Coda kernel module. Besides Coda clients
and servers have 'versioning' to detect conflicts, and have a convenient
'OldFiles' directory with the backup volume with yesterday's files. By
increasing the backup interval that could f.i. be the files you had an
hour ago.

The only reason why I think this doesn't affect the license is because
these solutions are not 'competing' with BK (yet) so they don't trigger
the "don't piss off Larry" clause...

I'm expecting that all the BK->gnu patch gateways will be shut down in
about 5 years, which should be around the time that other systems
(perhaps subversion) come in the 'competing with BK' stage. Because at
that point they are aiding in the wider deployment and development of
the competing version control system.

Jan

