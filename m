Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315338AbSFDRw0>; Tue, 4 Jun 2002 13:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315372AbSFDRwZ>; Tue, 4 Jun 2002 13:52:25 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:3337 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S315338AbSFDRwY>;
	Tue, 4 Jun 2002 13:52:24 -0400
Date: Tue, 4 Jun 2002 10:49:53 -0700
From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: device model documentation 2/3
Message-ID: <20020604174952.GD28805@kroah.com>
In-Reply-To: <Pine.LNX.4.33.0206040918490.654-100000@geena.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Tue, 07 May 2002 14:47:04 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2002 at 09:25:17AM -0700, Patrick Mochel wrote:
> 
> Document 2: driver.txt
> 
> This document includes two important points. For one, there is finally the 
> much promised description on the intended use of the power management 
> callbacks. 
> 
> Second, there is a proposed callback: init(). This would break driver 
> initialization apart from probe(). This has been discussed in the past, 
> and I believe with a positive result. If there are no objections, I will 
> implement the callback. Otherwise, I will fix the document. 

I think this is a good idea, at least for the USB drivers, and should be
implemented.

Thanks for writing up the documentation on this, it makes working with
the new code a much easier process :)

greg k-h
