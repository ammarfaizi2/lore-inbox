Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751274AbWFES31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWFES31 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 14:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWFES31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 14:29:27 -0400
Received: from cpe-71-64-120-181.neo.res.rr.com ([71.64.120.181]:12171 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S1751274AbWFES31
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 14:29:27 -0400
Date: Mon, 5 Jun 2006 14:42:05 -0400
From: Adam Belay <ambx1@neo.rr.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, Ryan Lortie <desrt@desrt.ca>,
        linux-kernel@vger.kernel.org, mjg59@srcf.ucam.org, bcollins@ubuntu.com,
        Greg KH <greg@kroah.com>
Subject: Re: pci_restore_state
Message-ID: <20060605184204.GA7534@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
	Ryan Lortie <desrt@desrt.ca>, linux-kernel@vger.kernel.org,
	mjg59@srcf.ucam.org, bcollins@ubuntu.com, Greg KH <greg@kroah.com>
References: <1149416010.30767.14.camel@moonpix.desrt.ca> <20060604032746.a5b3e2dd.akpm@osdl.org> <17538.49656.797376.483713@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17538.49656.797376.483713@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2006 at 09:20:24PM +1000, Paul Mackerras wrote:
> Andrew Morton writes:
> 
> > On Sun, 04 Jun 2006 06:13:30 -0400
> > Ryan Lortie <desrt@desrt.ca> wrote:
> > > If I reverse the for loop to start from 15 and count down to 0, then the
> > > majority of the configuration space is filled in _before_ the command
> > > word is modified.  No crash.
> > 
> > We have a patch pending which will do that.
> > 
> > http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-03-pci/pci-reverse-pci-config-space-restore-order.patch
> 
> We really shouldn't be writing to the BIST register, at least...
> 
> Also, I don't quite see the point of writing to the read-only
> registers such as vendor and device ID.
> 
> Paul.

Any comments on this patch as an alternative solution?

http://marc.theaimsgroup.com/?l=linux-kernel&m=114949711413176&w=2

Thanks,
Adam
