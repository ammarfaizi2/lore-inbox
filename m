Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262352AbVBXOZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbVBXOZO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 09:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbVBXOZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 09:25:14 -0500
Received: from users.linvision.com ([62.58.92.114]:57230 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S262352AbVBXOZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 09:25:07 -0500
Date: Thu, 24 Feb 2005 15:25:02 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Greg KH <greg@kroah.com>
Cc: mikem <mikem@beardog.cca.cpqcorp.net>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: CSMI questions
Message-ID: <20050224142502.GC13226@harddisk-recovery.com>
References: <20050222171656.GA5953@beardog.cca.cpqcorp.net> <20050222231450.GB10067@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050222231450.GB10067@kroah.com>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2005 at 03:14:50PM -0800, Greg KH wrote:
> On Tue, Feb 22, 2005 at 11:16:56AM -0600, mikem wrote:
> > I'd also like an (brief) explanation of why ioctls are so bad. I've seen the 
> > reasons of them never going away, etc. But from the beginning of time (UNIX)
> > ioctls have been the preferred method of user space/kernel communication.
> 
> That's because there was no other method.  See the lkml archives for why
> ioctls are considered bad, I don't want to dredge it up again.

Here's a quote from the official syndicated kernelnewbies fortunes
file (http://www.kernelnewbies.org/kernelnewbies-fortunes.tar.gz ):

"Basically, ioctl's will _never_ be done right, because of the way people
 think about them. They are a back door. They are by design typeless and
 without rules. They are, in fact, the Microsoft of UNIX."

	- Linus Torvalds on linux-kernel

For the full story, see http://lkml.org/lkml/2001/5/20/81 .


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
