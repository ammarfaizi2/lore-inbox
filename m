Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314078AbSEIS0h>; Thu, 9 May 2002 14:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314080AbSEIS0g>; Thu, 9 May 2002 14:26:36 -0400
Received: from host194.steeleye.com ([216.33.1.194]:37904 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S314078AbSEIS0f>; Thu, 9 May 2002 14:26:35 -0400
Message-Id: <200205091826.g49IQV503155@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Greg KH <greg@kroah.com>
cc: Patrick Mochel <mochel@osdl.org>, Linus Torvalds <torvalds@transmeta.com>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] PCI reorg fix 
In-Reply-To: Message from Greg KH <greg@kroah.com> 
   of "Thu, 09 May 2002 10:15:22 PDT." <20020509171522.GB17627@kroah.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 09 May 2002 14:26:31 -0400
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mochel@osdl.org said:
> Implementing the generic code is ~5 minutes work. However, it will
> break  everything. OTOH, it would be the best motivation for
> modernizing these  drivers... 

greg@kroah.com said:
> Eeek, the scsi drivers?  They haven't even started moving to the > 2
> years old pci interface yet!  :) 

It took several years to eliminate the old error handler, too...

If something's already broken, does it really matter how many pieces it's in?

There a siesmic changes coming to the scsi layer anyway, particularly if we 
want to implement the new tag queuing code.  The consistent alloc is virtually 
a simple conversion recipe, so it shouldn't be too difficult to tack this 
small change on to a set of much bigger ones.

James


