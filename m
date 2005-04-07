Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262555AbVDGTIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262555AbVDGTIO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 15:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262561AbVDGTIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 15:08:14 -0400
Received: from extgw-uk.mips.com ([62.254.210.129]:3859 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S262555AbVDGTHz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 15:07:55 -0400
Date: Thu, 7 Apr 2005 20:07:32 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1: ieee1394 process hang
Message-ID: <20050407190732.GB26850@linux-mips.org>
References: <4254F07B.1010500@goop.org> <20050407015845.6fb3c171.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050407015845.6fb3c171.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 01:58:45AM -0700, Andrew Morton wrote:

> > I'm having problems with 1394 in 2.6.12-rc2-mm1.  When I connect my
> >  Apple iSight camera, it is not detected; repeated
> >  connections/disconnections don't help.  When I tried to rmmod all the
> >  appropriate modules (rmmod video1394 raw1394 ohci1394 ieee1394), the
> >  rmmod command hung.  Alt-Sysreq-t shows this:
> 
> I don't think there have been any 1394 changes recently.  This bug might be
> more fallout from Pat's recent changes.
> 
> More attempts have been made to fix that stuff up.  Maybe you could try
> http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.12-rc2-mm1.5.gz

I'm not so sure, last week I had similar results with an external IEEE 1394
disk drive.  On the first attempt it wasn't detected, in the 2nd and 3rd
attempt detecting worked ok.  After copying a data for like 2min the system
paniced with no useful data in the log.  Further attempts resulted in more
hangs and panics.  The kernel was the latest and greatest FC3 kernel,
kernel-2.6.10-1.770_FC3.

(I'm a 1h flight away from the system so can't do any more testing on that
system)

  Ralf
