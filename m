Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264013AbUDQScR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 14:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264017AbUDQScR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 14:32:17 -0400
Received: from astound-64-85-224-245.ca.astound.net ([64.85.224.245]:782 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id S264013AbUDQScL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 14:32:11 -0400
Date: Sat, 17 Apr 2004 11:29:41 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Willy Tarreau <w@w.ods.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: SATA support in 2.4.27
In-Reply-To: <20040417100403.GB16284@alpha.home.local>
Message-ID: <Pine.LNX.4.10.10404171127040.22035-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I would be more concerned about changes in sector count between ATA and
SCSI; however, most people do not even know or look for such details.

Off by "ONE" has the effect of really torquing people.

This the main reason I object.

I suspect no one else even bothered to verify the difference.

Regards,

Andre Hedrick
LAD Storage Consulting Group

On Sat, 17 Apr 2004, Willy Tarreau wrote:

> On Sat, Apr 17, 2004 at 02:48:04AM -0700, Andre Hedrick wrote:
> > 
> > Willy,
> > 
> > See you get it ... just patch and go ... what is the problem, heh?
> 
> Andre,
> 
> There's no problem. I just do not make the confusion between mainline, which
> should keep compatible, and "add-ons" which sometimes can break compatibility
> with mainline, but which are targetted at experienced users. I'm happy that
> SATA goes into mainline IF it does not rename drives which currently work in
> earlier releases. That does not prevent me from using more advanced features
> and be prepared to change fstab and lila.confo on a particular machine
> if/when I upgrade. Mainline is *the* reference that even newbies can use
> for blind upgrades without risk. Fortunately, there are lots of wonderful
> things around to complete this stable reference.
> 
> Cheers,
> Willy
> 

