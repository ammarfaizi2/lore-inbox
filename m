Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbTEPWLW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 18:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbTEPWLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 18:11:22 -0400
Received: from Mail1.KONTENT.De ([81.88.34.36]:42113 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262524AbTEPWLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 18:11:21 -0400
From: Oliver Neukum <oliver@neukum.org>
To: jt@hpl.hp.com, Jean Tourrilhes <jt@bougret.hpl.hp.com>
Subject: Re: request_firmware() hotplug interface, third round.
Date: Sat, 17 May 2003 00:24:39 +0200
User-Agent: KMail/1.5.1
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20030515200324.GB12949@ranty.ddts.net> <200305161753.17198.oliver@neukum.org> <20030516184920.GA26221@bougret.hpl.hp.com>
In-Reply-To: <20030516184920.GA26221@bougret.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305170024.39724.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 16. Mai 2003 20:49 schrieb Jean Tourrilhes:
> On Fri, May 16, 2003 at 05:53:17PM +0200, Oliver Neukum wrote:
> > >  Hotpluggability is not required, it is the same for any module, which
> > >  gets loaded while the system is running. Drivers don't even need to be
> > >  aware of hotplug.
> >
> > In that case they can contain the firmware and mark it __init.
> > They need no RAM. They can even mark the code needed to put
> > firmware into the device as __init.
>
> 	I think you missed a lot of the previous discussion. Many high
> level kernel developpers (Jeff, Alan, Greg) have said 'niet' to binary
> firmware linked with the kernel (unless there is source code
> available). Please assume that all drivers currently including
> firmware blobs in the kernel will need fixing and therefore should not
> be taken as example.
> 	The threads :
> 		http://marc.theaimsgroup.com/?t=105222131600002&r=1&w=2
> 		http://marc.theaimsgroup.com/?t=105045487300002&r=1&w=2
> 		http://marc.theaimsgroup.com/?t=105181861200001&r=1&w=2
> 		http://marc.theaimsgroup.com/?t=105295022700002&r=1&w=2
> 		http://marc.theaimsgroup.com/?t=105302951900003&r=1&w=2
> 	Yes, that's a lot to read, but this will explain the full
> complexity of the situation.

It seems to be a whole lot of laywering not technical discussion IMHO.

> > An awful lot of overhead.
>
> 	It's not like we have a choice on this issue. The embedded
> people are already grumbling.

Please explain. Either firmware is in RAM or it is not.

	Regards
		Oliver

