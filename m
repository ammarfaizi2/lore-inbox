Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265248AbTFMIPx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 04:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265251AbTFMIPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 04:15:53 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:343 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S265248AbTFMIPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 04:15:13 -0400
Date: Fri, 13 Jun 2003 08:28:57 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
Cc: Arjan van de Ven <arjanv@redhat.com>, Andries Brouwer <aebr@win.tue.nl>,
       Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: open(.. O_DIRECT ..) difference in between Linux and FreeBSD ..
Message-ID: <20030613082857.G30329@devserv.devel.redhat.com>
References: <arjanv@redhat.com> <200306130827.h5D8RrJ5004185@verdi.et.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200306130827.h5D8RrJ5004185@verdi.et.tudelft.nl>; from robn@verdi.et.tudelft.nl on Fri, Jun 13, 2003 at 10:27:52AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 10:27:52AM +0200, Rob van Nieuwkerk wrote:
> 
> Arjan van de Ven wrote:
> > On Fri, Jun 13, 2003 at 01:12:57AM +0200, Rob van Nieuwkerk wrote:
> > > FYI:
> > > It appears that somewhere between RH kernels 2.4.18-27.7.x and 2.4.20-18.9
> > > something has changed so that my application needs a O_SYNC too besides
> > > the O_DIRECT to make sure that writes will be synchronous.  If I leave
> > > the O_SYNC out with 2.4.20-18.9 the write will happen physically 35
> > > seconds after the write() was done.
> > 
> > O_DIRECT is nothing but a hint and the 2.4.20-18.9 kernel decides to not
> > honor it
> 
> Hi Arjan,
> 
> Do you mean that the 2.4.20-18.9 kernel always ignores the O_DIRECT flag ?

yes.
