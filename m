Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314433AbSE2GH2>; Wed, 29 May 2002 02:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314483AbSE2GH1>; Wed, 29 May 2002 02:07:27 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:21011 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S314433AbSE2GH1>;
	Wed, 29 May 2002 02:07:27 -0400
Date: Tue, 28 May 2002 23:06:08 -0700
From: Greg KH <greg@kroah.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre9
Message-ID: <20020529060608.GB15260@kroah.com>
In-Reply-To: <Pine.LNX.4.21.0205281905260.7798-100000@freak.distro.conectiva> <20020529053732.GH6521@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 01 May 2002 04:31:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2002 at 07:37:33AM +0200, Lars Marowsky-Bree wrote:
> As a further comment:
> 
> > <greg@kroah.com> (02/05/03 1.408)
> > 	USB io_edgeport driver
> > 
> > <davem@nuts.ninka.net> (02/05/06 1.383.11.22)
> > 	soft-fp fix:
> >
> > <colin@gibbs.dhs.org> (02/05/07 1.383.11.23)
> > 	copy_mm fix:
> 
> and alike aren't actually very useful one-line summaries of the patch in
> question to a "casual" reader, sorry.
> 
> In the first case, I can guess that probably, it is a new driver added; or
> maybe it is just an update to an existing one?

An update:

ChangeSet@1.408, 2002-05-03 13:18:58-07:00, greg@kroah.com
  USB io_edgeport driver
    
  added support for Black Box OEM devices.

> The good work by all contributors not withstanding, it would be very nice if
> they could make the summary slightly more useful before sending a patch to
> Marcelo, for which I would like to thank everyone in advance ;-)

Condensing the patch summary into one line is a tough thing to do.  I
try to just mention the subsystem and specific driver (if any) on the
first line, and then go into the necessary detail on the following
lines.  That way if someone's interested in that specific subsystem or
driver, they can easily search and then later get more detail if they
want to.  Sound good?

thanks,

greg k-h
