Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317675AbSGLFDY>; Fri, 12 Jul 2002 01:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317983AbSGLFDX>; Fri, 12 Jul 2002 01:03:23 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:63241
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317675AbSGLFDW>; Fri, 12 Jul 2002 01:03:22 -0400
Date: Thu, 11 Jul 2002 22:03:16 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: andersen@codepoet.org, linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <3D2E5F40.9050202@zytor.com>
Message-ID: <Pine.LNX.4.10.10207112158000.20499-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jul 2002, H. Peter Anvin wrote:

> Erik Andersen wrote:
> >>
> >>Lovely.  Let's make EACH APPLICATION support two disjoint APIs for no 
> >>good reason.
> > 
> > Lovely.  Lets rip off a sarcastic answer without spending two
> > seconds to think.  Why would anybody need to support two APIs?  
> > The existing CDROM_SEND_PACKET ioctl is an ATAPI/SCSI pass
> > through interface, and is sufficient to operate both IDE and 
> > SCSI cd writers.
> > 
> 
> That's fine, but it still only supports CD writers.  We have a generic 
> packet interface for a good reason -- we should be able to access it 
> regardless of device type.
> 
> It's a specific solution to a generic problem.

Nice, so you still have to strip and export to the transport layer.

Please expand on what you are going to talk to packetized and the 
associated transport protocol restricted to the scope of storage.

Next count all the different personalitys associated with the discrete
transport layer.

If you are referring to Jens' pktcdvd interface out of block, it is no
more than a bypass of dealing with scsi.  It would allow direct access to
the physical transport without portions of OS mucking up things as it does
now.

Cheers,


Andre Hedrick
LAD Storage Consulting Group

